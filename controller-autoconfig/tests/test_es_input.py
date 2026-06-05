import os
from xml.etree import ElementTree as ET

from retrotools_controller.sdlmap import parse_line
from retrotools_controller.translate import translate
from retrotools_controller.writers import es_input

XBOX360 = (
    "030000005e0400008e02000010010000,Xbox 360 Controller,"
    "a:b0,b:b1,dpup:h0.1,leftx:a0,lefty:a1,start:b7,x:b2,y:b3,platform:Linux,"
)


def _inputs():
    return translate(parse_line(XBOX360))


def test_render_is_valid_xml_with_expected_attrs():
    contents = es_input.write_es_input(
        _inputs(), "Xbox 360 Controller", "030000005e0400008e02000010010000",
        dry_run=True,
    )
    assert contents.startswith('<?xml version="1.0"?>')
    root = ET.fromstring(contents.split("?>", 1)[1])
    assert root.tag == "inputList"
    cfg = root.find("inputConfig")
    assert cfg.get("deviceGUID") == "030000005e0400008e02000010010000"
    assert cfg.get("type") == "joystick"
    names = {i.get("name") for i in cfg.findall("input")}
    assert {"a", "b", "x", "y", "up", "start"} <= names


def test_write_then_merge_is_idempotent(tmp_path):
    path = os.path.join(tmp_path, "es_input.cfg")
    first = es_input.write_es_input(
        _inputs(), "Xbox 360 Controller", "030000005e0400008e02000010010000", path=path
    )
    second = es_input.write_es_input(
        _inputs(), "Xbox 360 Controller", "030000005e0400008e02000010010000", path=path
    )
    assert first == second
    # Exactly one inputConfig for this device.
    root = ET.parse(path).getroot()
    assert len(root.findall("inputConfig")) == 1


def test_existing_other_device_is_preserved(tmp_path):
    path = os.path.join(tmp_path, "es_input.cfg")
    seed = (
        '<?xml version="1.0"?>\n'
        '<inputList>\n'
        '  <inputConfig type="keyboard" deviceName="Keyboard" deviceGUID="-1">\n'
        '    <input name="a" type="key" id="120" value="1" />\n'
        '  </inputConfig>\n'
        '</inputList>\n'
    )
    with open(path, "w", encoding="utf-8") as fh:
        fh.write(seed)

    es_input.write_es_input(
        _inputs(), "Xbox 360 Controller", "030000005e0400008e02000010010000", path=path
    )
    root = ET.parse(path).getroot()
    guids = {c.get("deviceGUID") for c in root.findall("inputConfig")}
    assert "-1" in guids  # keyboard survived
    assert "030000005e0400008e02000010010000" in guids  # joystick added
    assert len(root.findall("inputConfig")) == 2
