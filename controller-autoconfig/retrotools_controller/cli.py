"""Command-line interface: detect | configure | list | update-db."""

from __future__ import annotations

import argparse
import sys
from typing import List, Optional

from . import __version__
from .db import DEFAULT_DB_PATH, ControllerDB, current_platform
from .detect import Controller, detect, from_json
from .guid import vidpid_key
from .sdlmap import SdlMapping
from .translate import translate
from .writers import es_input

UPSTREAM_DB_URL = (
    "https://raw.githubusercontent.com/mdqinc/SDL_GameControllerDB/master/"
    "gamecontrollerdb.txt"
)


def _layout_from_args(args) -> str:
    if getattr(args, "xbox_layout", False):
        return "xbox"
    return "nintendo"


def _load_db(args) -> ControllerDB:
    return ControllerDB.load(db_path=args.db) if getattr(args, "db", None) else ControllerDB.load()


def _read_controllers(args) -> List[Controller]:
    if getattr(args, "from_json", None):
        text = sys.stdin.read() if args.from_json == "-" else open(args.from_json).read()
        return from_json(text)
    return detect()


# --- commands -----------------------------------------------------------


def cmd_detect(args) -> int:
    db = _load_db(args)
    controllers = _read_controllers(args)
    if not controllers:
        print("No controllers detected.")
        print("(Install pysdl2 for best results, or pipe a detector via --from-json.)")
        return 1
    for i, c in enumerate(controllers):
        key = vidpid_key(c.vid, c.pid) if c.vid is not None and c.pid is not None else "?"
        mapping = db.resolve(vid=c.vid, pid=c.pid, guid=c.guid, name=c.name)
        status = "in DB" if mapping else "UNKNOWN (no mapping found)"
        print(f"[{i}] {c.name}")
        print(f"      vid:pid = {key}   guid = {c.guid or '-'}   source = {c.source}")
        print(f"      {status}")
    return 0


def cmd_configure(args) -> int:
    db = _load_db(args)
    controllers = _read_controllers(args)
    if not controllers:
        print("No controllers detected; nothing to configure.", file=sys.stderr)
        return 1

    index = args.controller or 0
    if index >= len(controllers):
        print(f"--controller {index} out of range (found {len(controllers)}).", file=sys.stderr)
        return 1
    c = controllers[index]

    mapping = db.resolve(vid=c.vid, pid=c.pid, guid=c.guid, name=c.name)
    if not mapping:
        print(f"No mapping found for {c.name}. Add one to db/overrides.json.", file=sys.stderr)
        return 2

    inputs = translate(mapping, layout=_layout_from_args(args))
    device_guid = c.guid or mapping.guid
    path = None if args.dry_run else (args.output or es_input.default_config_path())
    contents = es_input.write_es_input(
        inputs,
        device_name=c.name,
        device_guid=device_guid,
        path=path,
        dry_run=args.dry_run,
    )

    if args.dry_run:
        print(contents, end="")
    else:
        print(f"Wrote {len(inputs)} inputs for '{c.name}' to {path}")
    return 0


def cmd_list(args) -> int:
    db = _load_db(args)
    vid = int(args.vid, 16) if args.vid else None
    pid = int(args.pid, 16) if args.pid else None
    mapping: Optional[SdlMapping] = db.resolve(
        vid=vid, pid=pid, guid=args.guid, name=args.name
    )
    if not mapping:
        print("No mapping found for that controller.", file=sys.stderr)
        return 2
    inputs = translate(mapping, layout=_layout_from_args(args))
    print(f"# {mapping.name}  (guid {mapping.guid}, platform {mapping.platform})")
    contents = es_input.write_es_input(
        inputs, device_name=mapping.name, device_guid=mapping.guid, dry_run=True
    )
    print(contents, end="")
    return 0


def cmd_update_db(args) -> int:
    import urllib.request

    dest = args.db or DEFAULT_DB_PATH
    print(f"Downloading {UPSTREAM_DB_URL}\n  -> {dest}")
    try:
        with urllib.request.urlopen(UPSTREAM_DB_URL) as resp:
            data = resp.read()
    except Exception as exc:  # pragma: no cover - network dependent
        print(f"Update failed: {exc}", file=sys.stderr)
        return 1
    with open(dest, "wb") as fh:
        fh.write(data)
    lines = data.decode("utf-8", "replace").count("\n")
    print(f"Updated. {lines} lines.")
    return 0


# --- parser -------------------------------------------------------------


def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(
        prog="retrotools-controller",
        description="Detect a controller and auto-generate emulator input configs.",
    )
    p.add_argument("--version", action="version", version=f"%(prog)s {__version__}")
    p.add_argument("--db", help="path to gamecontrollerdb.txt (defaults to vendored copy)")
    sub = p.add_subparsers(dest="command", required=True)

    common_layout = argparse.ArgumentParser(add_help=False)
    g = common_layout.add_mutually_exclusive_group()
    g.add_argument(
        "--nintendo-layout",
        action="store_true",
        help="ES 'a' = east face button (default; correct for RetroPie/RetroArch)",
    )
    g.add_argument(
        "--xbox-layout",
        action="store_true",
        help="keep SDL's literal labels (ES 'a' = south face button)",
    )

    pd = sub.add_parser("detect", help="list connected controllers and DB status")
    pd.add_argument("--from-json", help="read detector JSON from FILE or '-' for stdin")
    pd.set_defaults(func=cmd_detect)

    pc = sub.add_parser("configure", parents=[common_layout], help="write es_input.cfg")
    pc.add_argument("--controller", type=int, default=0, help="index from 'detect' (default 0)")
    pc.add_argument("--output", help="es_input.cfg path (default: ~/.emulationstation/...)")
    pc.add_argument("--from-json", help="read detector JSON from FILE or '-' for stdin")
    pc.add_argument("--dry-run", action="store_true", help="print XML instead of writing")
    pc.set_defaults(func=cmd_configure)

    pl = sub.add_parser("list", parents=[common_layout], help="show a mapping without hardware")
    pl.add_argument("--vid", help="vendor id (hex, e.g. 045e)")
    pl.add_argument("--pid", help="product id (hex, e.g. 028e)")
    pl.add_argument("--guid", help="exact SDL GUID")
    pl.add_argument("--name", help="controller name")
    pl.set_defaults(func=cmd_list)

    pu = sub.add_parser("update-db", help="refresh the vendored gamecontrollerdb.txt")
    pu.set_defaults(func=cmd_update_db)

    return p


def main(argv: Optional[List[str]] = None) -> int:
    args = build_parser().parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    raise SystemExit(main())
