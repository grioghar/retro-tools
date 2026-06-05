from retrotools_controller.sdlmap import (
    Binding,
    MappingParseError,
    parse_binding,
    parse_line,
)

import pytest


def test_parse_button():
    assert parse_binding("b0") == Binding(kind="button", index=0)
    assert parse_binding("b13") == Binding(kind="button", index=13)


def test_parse_hat():
    assert parse_binding("h0.4") == Binding(kind="hat", index=0, hat_direction=4)


def test_parse_axis_full():
    assert parse_binding("a3") == Binding(kind="axis", index=3)


def test_parse_axis_inverted():
    b = parse_binding("a1~")
    assert b.kind == "axis" and b.index == 1 and b.inverted is True


def test_parse_axis_half():
    assert parse_binding("-a2").axis_half == "-"
    assert parse_binding("+a2").axis_half == "+"


def test_parse_axis_half_inverted():
    b = parse_binding("-a4~")
    assert b.axis_half == "-" and b.inverted is True


def test_bad_binding_raises():
    with pytest.raises(MappingParseError):
        parse_binding("z9")


def test_parse_line_xbox360_linux():
    line = (
        "030000005e0400008e02000010010000,Xbox 360 Controller,"
        "a:b0,b:b1,back:b6,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,dpup:h0.1,"
        "guide:b8,leftshoulder:b4,leftstick:b9,lefttrigger:a2,leftx:a0,"
        "lefty:a1,rightshoulder:b5,rightstick:b10,righttrigger:a5,rightx:a3,"
        "righty:a4,start:b7,x:b2,y:b3,platform:Linux,"
    )
    m = parse_line(line)
    assert m.guid == "030000005e0400008e02000010010000"
    assert m.name == "Xbox 360 Controller"
    assert m.platform == "Linux"
    assert m.bindings["a"] == Binding(kind="button", index=0)
    assert m.bindings["dpup"] == Binding(kind="hat", index=0, hat_direction=1)
    assert m.bindings["lefttrigger"] == Binding(kind="axis", index=2)


def test_parse_line_skips_comment_and_blank():
    for bad in ("", "   ", "# a comment"):
        with pytest.raises(MappingParseError):
            parse_line(bad)
