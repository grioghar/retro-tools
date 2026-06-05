import json
import os

from retrotools_controller.db import ControllerDB
from retrotools_controller.guid import vid_pid_from_guid, vidpid_key

# Xbox 360 USB IDs.
XBOX_GUID = "030000005e0400008e02000010010000"


def test_guid_vid_pid_extraction():
    assert vid_pid_from_guid(XBOX_GUID) == (0x045E, 0x028E)
    assert vidpid_key(0x045E, 0x028E) == "045e:028e"


def test_zero_guid_returns_none():
    assert vid_pid_from_guid("0" * 32) is None


def test_resolve_vendored_xbox360_on_linux():
    db = ControllerDB.load()
    m = db.resolve(vid=0x045E, pid=0x028E, platform="Linux")
    assert m is not None
    assert "Xbox 360" in m.name or "X360" in m.name
    assert m.platform == "Linux"


def test_override_wins_over_upstream(tmp_path):
    overrides = {
        "by_vidpid": {
            "045e:028e": {
                "name": "OVERRIDDEN PAD",
                "platform": "Linux",
                "mapping": "a:b5,start:b9",
            }
        },
        "by_guid": {},
    }
    op = os.path.join(tmp_path, "overrides.json")
    with open(op, "w") as fh:
        json.dump(overrides, fh)

    db = ControllerDB.load(overrides_path=op)
    m = db.resolve(vid=0x045E, pid=0x028E, platform="Linux")
    assert m.name == "OVERRIDDEN PAD"
    assert m.bindings["a"].index == 5


def test_unknown_controller_returns_none():
    # NB: 0xDEAD/0xBEEF is a real joke entry in upstream SDL_GameControllerDB,
    # so use IDs verified absent from the vendored snapshot instead.
    db = ControllerDB.load()
    assert db.resolve(vid=0x9999, pid=0x9991, platform="Linux") is None
