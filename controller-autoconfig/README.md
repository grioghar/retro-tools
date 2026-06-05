# Controller Auto-Configure

Detect a connected controller, read its USB vendor/product IDs, look it up in
the community [SDL_GameControllerDB](https://github.com/mdqinc/SDL_GameControllerDB),
and generate the emulator's input config automatically — so a freshly plugged-in
pad "just works" without manual button mapping.

**v1 target:** EmulationStation `es_input.cfg` (the RetroPie front-end input map).
On RetroPie, EmulationStation's own `inputconfiguration.sh` then propagates that
config to RetroArch and many emulators, so it's the highest-leverage first target.
RetroArch / standalone-emulator writers can be added later behind the same engine.

## How it works

```
detect ─▶ db lookup ─▶ parse SDL mapping ─▶ translate ─▶ write es_input.cfg
(VID/PID,  (VID/PID →    (a:b0, lefty:a1~,    (SDL → ES      (idempotent merge,
 GUID)      mapping)      dpup:h0.1 …)         names)          keyed by GUID)
```

- **Lookups key on USB VID/PID first.** The SDL GUID encodes VID/PID at fixed
  offsets, but its trailing bytes differ per OS, so the *same* controller has
  different GUIDs on Windows/Linux/macOS. VID/PID is the stable key; GUID and
  name are fallbacks. The database is also filtered by the running platform,
  because the same GUID can carry different button orderings per OS.
- **The database is vendored** (`db/gamecontrollerdb.txt`, zlib-licensed) so the
  tool works fully offline and reproducibly. `update-db` refreshes it.
  `db/overrides.json` is a local overlay that wins over upstream — for
  corrections or pads not yet in the community DB.

## Install

The engine is pure Python (standard library only) and runs on Windows, Linux,
and macOS. Live hardware detection is best with **pysdl2** installed; without
it, the tool falls back to OS-native USB enumeration, or you can feed it the
output of the native detector scripts.

```bash
pip install pysdl2 pysdl2-dll      # optional, for best live detection
```

## Usage

```bash
# List connected controllers and whether each is in the database
python -m retrotools_controller.cli detect

# Generate es_input.cfg for the first detected controller
python -m retrotools_controller.cli configure

# Preview the mapping for a specific controller without any hardware
python -m retrotools_controller.cli list --vid 045e --pid 028e

# Refresh the vendored database from upstream
python -m retrotools_controller.cli update-db
```

### Native detectors (no Python/SDL on the target)

Run detection natively and pipe the JSON into the engine:

```powershell
# Windows
powershell -File detectors/detect-windows.ps1 | `
    python -m retrotools_controller.cli configure --from-json -
```

```bash
# Linux / RetroPie
./detectors/detect-linux.sh | \
    python3 -m retrotools_controller.cli configure --from-json -
```

### Face-button layout

The classic A/B gotcha: RetroArch/RetroPie treat the **east** face button as
"A" (Nintendo/SNES convention), while SDL labels the **south** button "a".

- **Default (`--nintendo-layout`)** — ES "a" = east button. Correct for RetroPie.
- **`--xbox-layout`** — keep SDL's literal labels (ES "a" = south button).

## Layout

```
controller-autoconfig/
├─ db/
│  ├─ gamecontrollerdb.txt    vendored SDL_GameControllerDB snapshot (zlib)
│  └─ overrides.json          local overlay (wins over upstream)
├─ retrotools_controller/     the engine (pure-Python, the source of truth)
│  ├─ detect.py   db.py   sdlmap.py   guid.py   translate.py   cli.py
│  └─ writers/es_input.py
├─ detectors/
│  ├─ detect-windows.ps1      native VID/PID detection -> JSON
│  └─ detect-linux.sh
└─ tests/                     pytest suite (no hardware required)
```

## Testing

```bash
pip install pytest
python -m pytest controller-autoconfig/tests
```

The suite covers the SDL-mapping parser, the SDL→ES translator (face-layout,
hats, trigger axes, inverted sticks), the idempotent `es_input.cfg` merge
(including preserving an existing keyboard block), database resolution and
override precedence, and the detector→engine `--from-json` contract — all
without physical hardware.

## Known limitations

- Bluetooth pads and USB adapters (e.g. Mayflash) sometimes report the
  adapter's VID/PID rather than the controller's. Use `db/overrides.json` to
  pin a correct mapping.
- A controller absent from both the upstream DB and overrides is reported as
  `UNKNOWN` rather than guessed — add it to `overrides.json`.

## Credits & license

Bundles a snapshot of **SDL_GameControllerDB** by mdqinc and contributors,
distributed under the **zlib license** (compatible with this project's GPL-3.0).
See the header of `db/gamecontrollerdb.txt` for upstream attribution.
