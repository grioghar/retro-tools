"""retrotools_controller — controller auto-configuration engine for retro-tools.

Detect a connected controller, read its USB vendor/product IDs, look the
controller up in the community SDL_GameControllerDB, and emit an emulator
input config (EmulationStation es_input.cfg in this version).

The pipeline is: detect -> db lookup -> sdlmap parse -> translate -> writer.
Each stage is a small, independently testable module.
"""

__version__ = "0.1.0"
