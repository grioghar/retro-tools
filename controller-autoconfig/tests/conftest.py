"""Make the package importable when running pytest from the repo root."""

import os
import sys

# controller-autoconfig/ (parent of tests/) holds the package.
PKG_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if PKG_ROOT not in sys.path:
    sys.path.insert(0, PKG_ROOT)
