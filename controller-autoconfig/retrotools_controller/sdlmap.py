"""Parse a single SDL_GameControllerDB mapping line into structured bindings.

A mapping line looks like::

    030000005e0400008e02000010010000,Xbox 360 Controller,a:b0,b:b1,dpup:h0.1,\
        lefty:a1~,lefttrigger:a2,platform:Linux,

The first field is the SDL joystick GUID, the second is the human name, and
the rest are ``token:binding`` pairs.  Bindings come in three flavours:

* ``bN``                 -> button N
* ``hN.M``               -> hat N, direction-bitmask M (1=up,2=right,4=down,8=left)
* ``aN`` / ``+aN`` / ``-aN`` / ``aN~`` -> axis N, optional half (+/-) and inversion (~)

This module is pure: no I/O, no hardware.  It is the foundation the rest of
the engine builds on, so it is covered heavily by unit tests.
"""

from __future__ import annotations

import re
from dataclasses import dataclass
from typing import Dict, Optional

# Keys that are metadata, not button/axis bindings.
_META_KEYS = {"platform", "crc", "hint"}

_AXIS_RE = re.compile(r"^(?P<half>[+-]?)a(?P<index>\d+)(?P<invert>~?)$")
_BUTTON_RE = re.compile(r"^b(?P<index>\d+)$")
_HAT_RE = re.compile(r"^h(?P<index>\d+)\.(?P<direction>\d+)$")


@dataclass(frozen=True)
class Binding:
    """A physical input binding parsed from an SDL mapping value."""

    kind: str  # "button" | "axis" | "hat"
    index: int
    hat_direction: Optional[int] = None  # only for hats: 1/2/4/8
    axis_half: Optional[str] = None  # only for axes: "+" or "-" (None = full)
    inverted: bool = False  # only for axes: trailing "~"


@dataclass(frozen=True)
class SdlMapping:
    """A fully parsed SDL_GameControllerDB entry."""

    guid: str
    name: str
    platform: Optional[str]
    bindings: Dict[str, Binding]  # token (e.g. "a", "dpup", "leftx") -> Binding


class MappingParseError(ValueError):
    """Raised when a mapping line or binding value cannot be parsed."""


def parse_binding(value: str) -> Binding:
    """Parse a single binding value such as ``b0``, ``h0.4`` or ``-a1~``."""
    value = value.strip()

    m = _BUTTON_RE.match(value)
    if m:
        return Binding(kind="button", index=int(m.group("index")))

    m = _HAT_RE.match(value)
    if m:
        return Binding(
            kind="hat",
            index=int(m.group("index")),
            hat_direction=int(m.group("direction")),
        )

    m = _AXIS_RE.match(value)
    if m:
        half = m.group("half") or None
        return Binding(
            kind="axis",
            index=int(m.group("index")),
            axis_half=half,
            inverted=bool(m.group("invert")),
        )

    raise MappingParseError(f"unrecognised binding value: {value!r}")


def parse_line(line: str) -> SdlMapping:
    """Parse one full ``gamecontrollerdb.txt`` line into an :class:`SdlMapping`."""
    line = line.strip()
    if not line or line.startswith("#"):
        raise MappingParseError("not a mapping line (blank or comment)")

    # Trailing comma produces an empty final field; drop empties.
    fields = [f for f in line.split(",") if f != ""]
    if len(fields) < 2:
        raise MappingParseError(f"too few fields in mapping line: {line!r}")

    guid, name = fields[0], fields[1]
    platform: Optional[str] = None
    bindings: Dict[str, Binding] = {}

    for field in fields[2:]:
        if ":" not in field:
            # Tolerate stray tokens rather than failing the whole line.
            continue
        token, value = field.split(":", 1)
        token = token.strip()
        if token in _META_KEYS:
            if token == "platform":
                platform = value.strip()
            continue
        try:
            bindings[token] = parse_binding(value)
        except MappingParseError:
            # Skip individual unparseable bindings; keep the rest usable.
            continue

    return SdlMapping(guid=guid, name=name, platform=platform, bindings=bindings)
