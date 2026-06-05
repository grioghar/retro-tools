"""End-to-end test of the native-detector -> engine contract (--from-json)."""

import io
import os

from retrotools_controller.cli import main
from retrotools_controller.detect import from_json

# Shape emitted by detect-windows.ps1 / detect-linux.sh: vid/pid as hex strings.
DETECTOR_JSON = '[{"name":"X360 pad","vid":"045e","pid":"028e","source":"sysfs"}]'


def test_from_json_parses_hex_ids():
    cs = from_json(DETECTOR_JSON)
    assert len(cs) == 1
    assert cs[0].vid == 0x045E and cs[0].pid == 0x028E


def test_configure_via_from_json_dry_run(tmp_path, capsys, monkeypatch):
    jf = os.path.join(tmp_path, "det.json")
    with open(jf, "w") as fh:
        fh.write(DETECTOR_JSON)

    rc = main(["configure", "--from-json", jf, "--dry-run"])
    out = capsys.readouterr().out
    assert rc == 0
    assert "<inputConfig" in out
    assert 'name="a"' in out


def test_configure_via_from_json_writes_file(tmp_path):
    jf = os.path.join(tmp_path, "det.json")
    with open(jf, "w") as fh:
        fh.write(DETECTOR_JSON)
    out_cfg = os.path.join(tmp_path, "es_input.cfg")

    rc = main(["configure", "--from-json", jf, "--output", out_cfg])
    assert rc == 0
    assert os.path.isfile(out_cfg)
    assert "inputConfig" in open(out_cfg).read()


def test_detect_reports_unknown(tmp_path, capsys):
    jf = os.path.join(tmp_path, "det.json")
    with open(jf, "w") as fh:
        fh.write('[{"name":"Mystery","vid":"9999","pid":"9991"}]')
    rc = main(["detect", "--from-json", jf])
    out = capsys.readouterr().out
    assert rc == 0
    assert "UNKNOWN" in out
