"""Helpers for the 16-byte SDL joystick GUID.

Layout (little-endian, 32 hex chars / 16 bytes)::

    bytes 0-1  bus type
    bytes 2-3  0000
    bytes 4-5  vendor id (VID)      <- hex offset [8:12]
    bytes 6-7  0000
    bytes 8-9  product id (PID)     <- hex offset [16:20]
    bytes 10-11 0000
    bytes 12-13 version
    bytes 14-15 driver/controller type (varies per OS)

The trailing bytes differ across operating systems for the *same* physical
controller, which is why VID/PID (stable) is the preferred lookup key.
"""

from __future__ import annotations

from typing import Optional, Tuple


def _le16(hex4: str) -> int:
    """Interpret 4 hex chars (2 little-endian bytes) as an int."""
    if len(hex4) != 4:
        raise ValueError(f"expected 4 hex chars, got {hex4!r}")
    return int(hex4[2:4] + hex4[0:2], 16)


def vid_pid_from_guid(guid: str) -> Optional[Tuple[int, int]]:
    """Extract ``(vid, pid)`` from an SDL GUID, or ``None`` if not encoded.

    A zero VID typically means the GUID is name-based (e.g. some bluetooth or
    virtual devices) and carries no usable USB IDs.
    """
    guid = guid.strip().lower()
    if len(guid) != 32:
        return None
    try:
        vid = _le16(guid[8:12])
        pid = _le16(guid[16:20])
    except ValueError:
        return None
    if vid == 0 and pid == 0:
        return None
    return vid, pid


def vidpid_key(vid: int, pid: int) -> str:
    """Canonical ``"vvvv:pppp"`` lowercase hex key used across the engine."""
    return f"{vid:04x}:{pid:04x}"
