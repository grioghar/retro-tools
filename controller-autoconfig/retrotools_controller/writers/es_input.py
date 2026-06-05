"""Render and merge EmulationStation ``es_input.cfg`` files.

The file is XML::

    <inputList>
      <inputConfig type="joystick" deviceName="..." deviceGUID="...">
        <input name="a" type="button" id="0" value="1" />
        ...
      </inputConfig>
    </inputList>

The merge is *idempotent*: writing the same controller twice produces no diff,
and existing entries for other devices (including the keyboard) are preserved.
A controller's existing block is matched and replaced by ``deviceGUID``.
"""

from __future__ import annotations

import os
from typing import List, Optional
from xml.etree import ElementTree as ET

from ..translate import EsInput


def default_config_path() -> str:
    """Return the conventional es_input.cfg location for the current user."""
    return os.path.join(
        os.path.expanduser("~"), ".emulationstation", "es_input.cfg"
    )


def build_input_config(
    device_name: str, device_guid: str, inputs: List[EsInput]
) -> ET.Element:
    """Build a single ``<inputConfig>`` element for one controller."""
    cfg = ET.Element(
        "inputConfig",
        {
            "type": "joystick",
            "deviceName": device_name,
            "deviceGUID": device_guid,
        },
    )
    for inp in inputs:
        ET.SubElement(cfg, "input", inp.as_attrs())
    return cfg


def _load_or_new_root(path: Optional[str]) -> ET.Element:
    if path and os.path.isfile(path):
        tree = ET.parse(path)
        root = tree.getroot()
        if root.tag == "inputList":
            return root
    return ET.Element("inputList")


def merge_input_config(
    root: ET.Element, new_cfg: ET.Element
) -> ET.Element:
    """Insert or replace ``new_cfg`` in ``root`` keyed by deviceGUID.

    Returns the same ``root`` for convenience.
    """
    guid = new_cfg.get("deviceGUID")
    for i, existing in enumerate(list(root)):
        if (
            existing.tag == "inputConfig"
            and existing.get("deviceGUID") == guid
            and existing.get("type") == new_cfg.get("type")
        ):
            root[i] = new_cfg
            return root
    root.append(new_cfg)
    return root


def _indent(elem: ET.Element, level: int = 0) -> None:
    """Pretty-print indentation (stdlib ET.indent exists only on 3.9+)."""
    pad = "\n" + "    " * level
    child_pad = "\n" + "    " * (level + 1)
    if len(elem):
        if not (elem.text or "").strip():
            elem.text = child_pad
        for child in elem:
            _indent(child, level + 1)
            if not (child.tail or "").strip():
                child.tail = child_pad
        if not (elem[-1].tail or "").strip():
            elem[-1].tail = pad
    else:
        if level and not (elem.tail or "").strip():
            elem.tail = pad


def render(root: ET.Element) -> str:
    """Serialise an ``<inputList>`` root to a UTF-8 XML string."""
    _indent(root)
    body = ET.tostring(root, encoding="unicode")
    return '<?xml version="1.0"?>\n' + body + "\n"


def write_es_input(
    inputs: List[EsInput],
    device_name: str,
    device_guid: str,
    path: Optional[str] = None,
    dry_run: bool = False,
) -> str:
    """Merge one controller's mapping into es_input.cfg.

    Returns the full rendered file contents.  When ``dry_run`` is False and a
    ``path`` is given, the file is written (creating parent dirs as needed).
    """
    root = _load_or_new_root(path)
    new_cfg = build_input_config(device_name, device_guid, inputs)
    merge_input_config(root, new_cfg)
    contents = render(root)

    if not dry_run and path:
        os.makedirs(os.path.dirname(os.path.abspath(path)), exist_ok=True)
        with open(path, "w", encoding="utf-8", newline="\n") as fh:
            fh.write(contents)
    return contents
