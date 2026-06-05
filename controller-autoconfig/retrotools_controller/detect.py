"""Detect connected controllers and normalise them to a common record.

Detection backends, tried in order:

1. **SDL2** (via ``pysdl2``) — best: yields the exact SDL GUID + name the
   target emulator will see on this OS, plus button/axis/hat counts.
2. **evdev/sysfs** (Linux) or **WMI** (Windows) — fallback that recovers at
   least VID/PID + name when SDL is unavailable.
3. **--from-json** — accept a record produced by the native detector scripts
   (``detectors/detect-*.{ps1,sh}``) so the engine runs where Python/SDL is
   undesirable.

Each backend returns zero or more :class:`Controller` records.
"""

from __future__ import annotations

import json
from dataclasses import asdict, dataclass
from typing import List, Optional

from .guid import vid_pid_from_guid


@dataclass
class Controller:
    """A normalised view of a connected controller."""

    name: str
    guid: Optional[str] = None
    vid: Optional[int] = None
    pid: Optional[int] = None
    num_buttons: Optional[int] = None
    num_axes: Optional[int] = None
    num_hats: Optional[int] = None
    source: str = "unknown"  # which backend produced this record

    def __post_init__(self) -> None:
        # Backfill vid/pid from the GUID when the backend didn't supply them.
        if (self.vid is None or self.pid is None) and self.guid:
            vp = vid_pid_from_guid(self.guid)
            if vp:
                self.vid, self.pid = vp

    def to_dict(self) -> dict:
        return asdict(self)


def detect() -> List[Controller]:
    """Return all controllers found via the best available backend."""
    controllers = _detect_sdl2()
    if controllers:
        return controllers
    return _detect_fallback()


def from_json(text: str) -> List[Controller]:
    """Parse controller records emitted by a native detector script.

    Accepts either a single object or a list of objects with keys matching
    :class:`Controller` fields (``vid``/``pid`` may be hex strings).
    """
    data = json.loads(text)
    if isinstance(data, dict):
        data = [data]
    out: List[Controller] = []
    for item in data:
        out.append(
            Controller(
                name=item.get("name", "Unknown Controller"),
                guid=item.get("guid"),
                vid=_coerce_id(item.get("vid")),
                pid=_coerce_id(item.get("pid")),
                num_buttons=item.get("num_buttons"),
                num_axes=item.get("num_axes"),
                num_hats=item.get("num_hats"),
                source=item.get("source", "from-json"),
            )
        )
    return out


def _coerce_id(value) -> Optional[int]:
    if value is None or isinstance(value, int):
        return value
    s = str(value).strip().lower().replace("0x", "")
    try:
        return int(s, 16)
    except ValueError:
        try:
            return int(s)
        except ValueError:
            return None


def _detect_sdl2() -> List[Controller]:
    try:
        import sdl2  # type: ignore
    except Exception:
        return []

    out: List[Controller] = []
    try:
        sdl2.SDL_Init(sdl2.SDL_INIT_JOYSTICK)
        count = sdl2.SDL_NumJoysticks()
        for i in range(count):
            joy = sdl2.SDL_JoystickOpen(i)
            if not joy:
                continue
            try:
                name = sdl2.SDL_JoystickName(joy)
                name = name.decode() if isinstance(name, bytes) else str(name)
                guid_obj = sdl2.SDL_JoystickGetGUID(joy)
                buf = (sdl2.c_char * 33)()
                sdl2.SDL_JoystickGetGUIDString(guid_obj, buf, 33)
                guid = buf.value.decode()
                out.append(
                    Controller(
                        name=name,
                        guid=guid,
                        num_buttons=sdl2.SDL_JoystickNumButtons(joy),
                        num_axes=sdl2.SDL_JoystickNumAxes(joy),
                        num_hats=sdl2.SDL_JoystickNumHats(joy),
                        source="sdl2",
                    )
                )
            finally:
                sdl2.SDL_JoystickClose(joy)
    finally:
        try:
            sdl2.SDL_Quit()
        except Exception:
            pass
    return out


def _detect_fallback() -> List[Controller]:
    import sys

    if sys.platform.startswith("linux"):
        return _detect_linux_sysfs()
    if sys.platform.startswith("win"):
        return _detect_windows_wmi()
    return []


def _detect_linux_sysfs() -> List[Controller]:
    """Best-effort Linux detection without SDL, walking /sys input devices."""
    import glob
    import os

    out: List[Controller] = []
    for js in sorted(glob.glob("/sys/class/input/js*")):
        dev = os.path.join(js, "device")
        try:
            name = _read(os.path.join(dev, "name")) or "Joystick"
            vid = _read_hex(os.path.join(dev, "id", "vendor"))
            pid = _read_hex(os.path.join(dev, "id", "product"))
        except Exception:
            continue
        out.append(Controller(name=name, vid=vid, pid=pid, source="sysfs"))
    return out


def _detect_windows_wmi() -> List[Controller]:
    """Best-effort Windows detection via PowerShell Get-PnpDevice."""
    import subprocess

    ps = (
        "Get-CimInstance Win32_PNPEntity | "
        "Where-Object { $_.PNPClass -eq 'HIDClass' -or "
        "$_.Service -eq 'HidUsb' -or $_.Name -match 'controller|gamepad|joystick' } | "
        "Where-Object { $_.DeviceID -match 'VID_' } | "
        "Select-Object Name,DeviceID | ConvertTo-Json -Compress"
    )
    try:
        raw = subprocess.check_output(
            ["powershell", "-NoProfile", "-Command", ps],
            text=True,
            stderr=subprocess.DEVNULL,
        )
    except Exception:
        return []
    return _parse_windows_pnp(raw)


def _parse_windows_pnp(raw: str) -> List[Controller]:
    import re

    try:
        data = json.loads(raw) if raw.strip() else []
    except json.JSONDecodeError:
        return []
    if isinstance(data, dict):
        data = [data]
    out: List[Controller] = []
    for item in data:
        dev_id = item.get("DeviceID", "")
        vm = re.search(r"VID_([0-9A-Fa-f]{4})", dev_id)
        pm = re.search(r"PID_([0-9A-Fa-f]{4})", dev_id)
        out.append(
            Controller(
                name=item.get("Name", "Controller"),
                vid=int(vm.group(1), 16) if vm else None,
                pid=int(pm.group(1), 16) if pm else None,
                source="wmi",
            )
        )
    return out


def _read(path: str) -> Optional[str]:
    try:
        with open(path, "r") as fh:
            return fh.read().strip()
    except Exception:
        return None


def _read_hex(path: str) -> Optional[int]:
    val = _read(path)
    try:
        return int(val, 16) if val else None
    except ValueError:
        return None
