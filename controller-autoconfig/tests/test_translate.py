from retrotools_controller.sdlmap import parse_line
from retrotools_controller.translate import EsInput, translate

XBOX360_LINUX = (
    "030000005e0400008e02000010010000,Xbox 360 Controller,"
    "a:b0,b:b1,back:b6,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,"
    "guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,"
    "lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,"
    "righty:a4,start:b7,x:b2,y:b3,platform:Linux,"
)


def _by_name(inputs):
    return {i.name: i for i in inputs}


def test_nintendo_layout_swaps_face_buttons():
    m = parse_line(XBOX360_LINUX)
    out = _by_name(translate(m, layout="nintendo"))
    # ES 'a' should map to the EAST button = SDL 'b' = b1.
    assert out["a"] == EsInput("a", "button", 1, 1)
    assert out["b"] == EsInput("b", "button", 0, 1)
    assert out["x"] == EsInput("x", "button", 3, 1)
    assert out["y"] == EsInput("y", "button", 2, 1)


def test_xbox_layout_keeps_labels():
    m = parse_line(XBOX360_LINUX)
    out = _by_name(translate(m, layout="xbox"))
    assert out["a"] == EsInput("a", "button", 0, 1)
    assert out["b"] == EsInput("b", "button", 1, 1)


def test_dpad_hats_and_meta_buttons():
    out = _by_name(translate(parse_line(XBOX360_LINUX)))
    assert out["up"] == EsInput("up", "hat", 0, 1)
    assert out["down"] == EsInput("down", "hat", 0, 4)
    assert out["left"] == EsInput("left", "hat", 0, 8)
    assert out["right"] == EsInput("right", "hat", 0, 2)
    assert out["select"] == EsInput("select", "button", 6, 1)
    assert out["start"] == EsInput("start", "button", 7, 1)
    assert out["hotkeyenable"] == EsInput("hotkeyenable", "button", 8, 1)


def test_triggers_as_axes():
    out = _by_name(translate(parse_line(XBOX360_LINUX)))
    assert out["lefttrigger"] == EsInput("lefttrigger", "axis", 2, 1)
    assert out["righttrigger"] == EsInput("righttrigger", "axis", 5, 1)


def test_sticks_expand_to_two_directions():
    out = _by_name(translate(parse_line(XBOX360_LINUX)))
    assert out["leftanalogleft"] == EsInput("leftanalogleft", "axis", 0, -1)
    assert out["leftanalogright"] == EsInput("leftanalogright", "axis", 0, 1)
    assert out["leftanalogup"] == EsInput("leftanalogup", "axis", 1, -1)
    assert out["leftanalogdown"] == EsInput("leftanalogdown", "axis", 1, 1)


def test_inverted_stick_axis_flips_sign():
    line = "030000001234000056780000,Pad,lefty:a1~,platform:Linux,"
    out = _by_name(translate(parse_line(line)))
    assert out["leftanalogup"] == EsInput("leftanalogup", "axis", 1, 1)
    assert out["leftanalogdown"] == EsInput("leftanalogdown", "axis", 1, -1)
