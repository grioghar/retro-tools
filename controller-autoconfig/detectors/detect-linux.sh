#!/usr/bin/env bash
#
# Detect connected game controllers on Linux (incl. RetroPie) and emit
# normalized JSON for the Python engine:
#
#     ./detect-linux.sh | python3 -m retrotools_controller.cli detect --from-json -
#
# Reads VID/PID and name from /sys for each /dev/input/js* device. No external
# dependencies beyond coreutils; works on a stock RetroPie over SSH.

set -euo pipefail

emit_json() {
    # $1=name $2=vid(hex) $3=pid(hex)
    printf '{"name":"%s","vid":"%s","pid":"%s","source":"sysfs"}' \
        "$(printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g')" "$2" "$3"
}

first=1
printf '['
for js in /sys/class/input/js*; do
    [ -e "$js" ] || continue
    dev="$js/device"

    name="Joystick"
    [ -r "$dev/name" ] && name="$(cat "$dev/name")"

    vid=""
    pid=""
    if [ -r "$dev/id/vendor" ]; then vid="$(cat "$dev/id/vendor")"; fi
    if [ -r "$dev/id/product" ]; then pid="$(cat "$dev/id/product")"; fi

    # Fall back to the parent USB device when the input node lacks id/*.
    if [ -z "$vid" ] && [ -r "$dev/../id/vendor" ]; then
        vid="$(cat "$dev/../id/vendor")"
        pid="$(cat "$dev/../id/product")"
    fi

    [ -n "$vid" ] || continue

    if [ "$first" -eq 0 ]; then printf ','; fi
    first=0
    emit_json "$name" "${vid,,}" "${pid,,}"
done
printf ']\n'
