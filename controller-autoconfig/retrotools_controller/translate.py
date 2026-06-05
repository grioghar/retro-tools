"""Translate parsed SDL bindings into EmulationStation input entries.

SDL_GameControllerDB describes controllers with Xbox-style semantic tokens
(``a`` = south face button, ``b`` = east, etc.).  EmulationStation's
``es_input.cfg`` uses its own input names and a ``type``/``id``/``value``
encoding.  This module is the bridge.

Two subtleties handled here:

* **Face-button layout.**  RetroArch/RetroPie treat the *east* face button as
  "A" (SNES/Nintendo convention), whereas SDL labels the *south* button "a".
  The default layout therefore swaps the diagonals so the resulting config
  behaves correctly on a RetroPie.  Pass ``layout="xbox"`` to keep SDL's
  literal labels instead.
* **Analog sticks.**  A single SDL stick axis (``leftx`` ...) expands into two
  directional EmulationStation inputs (left/right or up/down), with the sign
  flipped when the axis is inverted (``~``).
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import Dict, List

from .sdlmap import Binding, SdlMapping

# --- Face-button layouts -------------------------------------------------

# Nintendo/RetroPie positional layout: ES "a" is the EAST button.
# SDL: a=south, b=east, x=west, y=north.  So ES a<-SDL b, b<-SDL a, x<-SDL y, y<-SDL x.
_FACE_NINTENDO = {"a": "b", "b": "a", "x": "y", "y": "x"}
# Xbox literal layout: keep SDL labels as-is.
_FACE_XBOX = {"a": "a", "b": "b", "x": "x", "y": "y"}

# SDL token -> single ES input name (non-face, digital / trigger targets).
_DIGITAL = {
    "back": "select",
    "start": "start",
    "guide": "hotkeyenable",
    "dpup": "up",
    "dpdown": "down",
    "dpleft": "left",
    "dpright": "right",
    "leftshoulder": "leftshoulder",
    "rightshoulder": "rightshoulder",
    "lefttrigger": "lefttrigger",
    "righttrigger": "righttrigger",
    "leftstick": "leftthumb",
    "rightstick": "rightthumb",
}

# SDL stick-axis token -> (negative-direction ES name, positive-direction ES name).
_STICK_AXES = {
    "leftx": ("leftanalogleft", "leftanalogright"),
    "lefty": ("leftanalogup", "leftanalogdown"),
    "rightx": ("rightanalogleft", "rightanalogright"),
    "righty": ("rightanalogup", "rightanalogdown"),
}


@dataclass(frozen=True)
class EsInput:
    """One EmulationStation ``<input>`` entry."""

    name: str
    type: str  # "button" | "axis" | "hat"
    id: int
    value: int

    def as_attrs(self) -> Dict[str, str]:
        return {
            "name": self.name,
            "type": self.type,
            "id": str(self.id),
            "value": str(self.value),
        }


def _digital_input(name: str, binding: Binding) -> EsInput:
    """Render a binding that targets a single (digital-ish) ES input.

    Buttons and hats map directly.  An axis target (common for triggers) is
    emitted as an axis input whose sign reflects the half/inversion.
    """
    if binding.kind == "button":
        return EsInput(name, "button", binding.index, 1)
    if binding.kind == "hat":
        return EsInput(name, "hat", binding.index, binding.hat_direction or 0)
    # axis: pick the active sign. "-a" => -1, otherwise +1; "~" flips it.
    sign = -1 if binding.axis_half == "-" else 1
    if binding.inverted:
        sign = -sign
    return EsInput(name, "axis", binding.index, sign)


def _stick_inputs(neg_name: str, pos_name: str, binding: Binding) -> List[EsInput]:
    """Expand a stick axis into its two directional ES inputs."""
    if binding.kind != "axis":
        # Defensive: some pads bind a "stick" token to a button/hat. Treat as
        # a single digital input on the negative-direction name.
        return [_digital_input(neg_name, binding)]
    neg_value, pos_value = -1, 1
    if binding.inverted:
        neg_value, pos_value = pos_value, neg_value
    return [
        EsInput(neg_name, "axis", binding.index, neg_value),
        EsInput(pos_name, "axis", binding.index, pos_value),
    ]


def translate(mapping: SdlMapping, layout: str = "nintendo") -> List[EsInput]:
    """Translate an :class:`SdlMapping` into ordered EmulationStation inputs.

    ``layout`` is ``"nintendo"`` (default, ES "a" = east face button) or
    ``"xbox"`` (literal SDL labels).
    """
    if layout not in ("nintendo", "xbox"):
        raise ValueError(f"unknown layout: {layout!r} (use 'nintendo' or 'xbox')")
    face = _FACE_NINTENDO if layout == "nintendo" else _FACE_XBOX

    inputs: List[EsInput] = []
    b = mapping.bindings

    # Face buttons, in a stable ES-friendly order.
    for es_name in ("a", "b", "x", "y"):
        sdl_token = face[es_name]
        if sdl_token in b:
            inputs.append(_digital_input(es_name, b[sdl_token]))

    # Other digital / trigger targets.
    for sdl_token, es_name in _DIGITAL.items():
        if sdl_token in b:
            inputs.append(_digital_input(es_name, b[sdl_token]))

    # Analog sticks (each expands to two directional inputs).
    for sdl_token, (neg_name, pos_name) in _STICK_AXES.items():
        if sdl_token in b:
            inputs.extend(_stick_inputs(neg_name, pos_name, b[sdl_token]))

    return inputs
