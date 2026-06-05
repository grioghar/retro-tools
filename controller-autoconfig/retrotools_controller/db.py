"""Load the controller database and resolve a controller to an SDL mapping.

Sources, in precedence order:

1. ``overrides.json`` — our overlay (corrections + pads missing upstream).
2. ``gamecontrollerdb.txt`` — vendored SDL_GameControllerDB snapshot.

Resolution for a detected controller (vid/pid/guid/name on the current OS):

1. override by GUID, then by vid:pid
2. upstream exact GUID on the current platform
3. upstream vid:pid on the current platform
4. upstream vid:pid on any platform
5. upstream by name (last resort)
"""

from __future__ import annotations

import json
import os
import sys
from typing import Dict, List, Optional

from .guid import vid_pid_from_guid, vidpid_key
from .sdlmap import SdlMapping, parse_line

_HERE = os.path.dirname(os.path.abspath(__file__))
_DB_DIR = os.path.normpath(os.path.join(_HERE, os.pardir, "db"))
DEFAULT_DB_PATH = os.path.join(_DB_DIR, "gamecontrollerdb.txt")
DEFAULT_OVERRIDES_PATH = os.path.join(_DB_DIR, "overrides.json")


def current_platform() -> str:
    """Map the running OS to an SDL_GameControllerDB ``platform:`` tag."""
    if sys.platform.startswith("win"):
        return "Windows"
    if sys.platform == "darwin":
        return "Mac OS X"
    if sys.platform.startswith("linux"):
        return "Linux"
    return "Linux"


class ControllerDB:
    """An in-memory view of the upstream DB plus local overrides."""

    def __init__(
        self,
        mappings: List[SdlMapping],
        overrides_by_guid: Optional[Dict[str, SdlMapping]] = None,
        overrides_by_vidpid: Optional[Dict[str, SdlMapping]] = None,
    ) -> None:
        self.mappings = mappings
        self.overrides_by_guid = overrides_by_guid or {}
        self.overrides_by_vidpid = overrides_by_vidpid or {}

    # -- loading ---------------------------------------------------------

    @classmethod
    def load(
        cls,
        db_path: str = DEFAULT_DB_PATH,
        overrides_path: str = DEFAULT_OVERRIDES_PATH,
    ) -> "ControllerDB":
        mappings: List[SdlMapping] = []
        with open(db_path, "r", encoding="utf-8") as fh:
            for line in fh:
                line = line.strip()
                if not line or line.startswith("#"):
                    continue
                try:
                    mappings.append(parse_line(line))
                except Exception:
                    continue

        by_guid: Dict[str, SdlMapping] = {}
        by_vidpid: Dict[str, SdlMapping] = {}
        if overrides_path and os.path.isfile(overrides_path):
            by_guid, by_vidpid = _load_overrides(overrides_path)

        return cls(mappings, by_guid, by_vidpid)

    # -- lookup ----------------------------------------------------------

    def resolve(
        self,
        vid: Optional[int] = None,
        pid: Optional[int] = None,
        guid: Optional[str] = None,
        name: Optional[str] = None,
        platform: Optional[str] = None,
    ) -> Optional[SdlMapping]:
        """Return the best SDL mapping for a controller, or ``None``."""
        platform = platform or current_platform()
        guid_l = guid.lower() if guid else None

        # Derive vid/pid from the GUID when not supplied.
        if (vid is None or pid is None) and guid_l:
            vp = vid_pid_from_guid(guid_l)
            if vp:
                vid, pid = vp
        key = vidpid_key(vid, pid) if vid is not None and pid is not None else None

        # 1. overrides
        if guid_l and guid_l in self.overrides_by_guid:
            return self.overrides_by_guid[guid_l]
        if key and key in self.overrides_by_vidpid:
            return self.overrides_by_vidpid[key]

        # 2. exact GUID on current platform
        if guid_l:
            for m in self.mappings:
                if m.guid.lower() == guid_l and m.platform == platform:
                    return m

        # 3. vid:pid on current platform
        if key:
            for m in self.mappings:
                if m.platform == platform and _guid_key(m.guid) == key:
                    return m
            # 4. vid:pid on any platform
            for m in self.mappings:
                if _guid_key(m.guid) == key:
                    return m

        # 5. name match (last resort)
        if name:
            name_l = name.strip().lower()
            for m in self.mappings:
                if m.name.lower() == name_l and m.platform == platform:
                    return m
            for m in self.mappings:
                if m.name.lower() == name_l:
                    return m

        return None


def _guid_key(guid: str) -> Optional[str]:
    vp = vid_pid_from_guid(guid)
    return vidpid_key(*vp) if vp else None


def _load_overrides(path: str):
    """Parse overrides.json into guid/vidpid -> SdlMapping dicts.

    Schema::

        {
          "by_vidpid": {
            "045e:028e": {"name": "...", "mapping": "a:b0,b:b1,...",
                            "platform": "Windows"}
          },
          "by_guid": { "<guid>": { ...same shape... } }
        }
    """
    with open(path, "r", encoding="utf-8") as fh:
        data = json.load(fh)

    by_guid: Dict[str, SdlMapping] = {}
    by_vidpid: Dict[str, SdlMapping] = {}

    for guid, entry in (data.get("by_guid") or {}).items():
        by_guid[guid.lower()] = _entry_to_mapping(guid, entry)
    for key, entry in (data.get("by_vidpid") or {}).items():
        # Synthesize a placeholder GUID carrying the vid/pid so downstream code
        # (which may read mapping.guid) still works.
        synth_guid = entry.get("guid") or _synth_guid(key)
        by_vidpid[key.lower()] = _entry_to_mapping(synth_guid, entry)

    return by_guid, by_vidpid


def _entry_to_mapping(guid: str, entry: dict) -> SdlMapping:
    name = entry.get("name", "Override Controller")
    mapping = entry.get("mapping", "")
    platform = entry.get("platform", current_platform())
    line = f"{guid},{name},{mapping},platform:{platform},"
    return parse_line(line)


def _synth_guid(vidpid: str) -> str:
    """Build a USB-bus GUID string that encodes the given vid:pid."""
    vid, pid = (int(x, 16) for x in vidpid.split(":"))
    vid_le = f"{vid & 0xFF:02x}{(vid >> 8) & 0xFF:02x}"
    pid_le = f"{pid & 0xFF:02x}{(pid >> 8) & 0xFF:02x}"
    return f"03000000{vid_le}0000{pid_le}0000000000000000"[:32]
