<#
.SYNOPSIS
    Detect connected game controllers on Windows and emit normalized JSON.

.DESCRIPTION
    Reads USB VID/PID from PnP device IDs via CIM/WMI. Output is a JSON array
    of {name, vid, pid, source} objects that the Python engine consumes:

        powershell -File detect-windows.ps1 | python -m retrotools_controller.cli detect --from-json -

    This lets the engine run on machines where installing Python/SDL on the
    target is undesirable -- the detection happens natively, the mapping
    happens in the shared engine.
#>

[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$devices = Get-CimInstance Win32_PNPEntity |
    Where-Object {
        $_.DeviceID -match 'VID_[0-9A-Fa-f]{4}&PID_[0-9A-Fa-f]{4}' -and
        ($_.PNPClass -eq 'HIDClass' -or
         $_.Service -in @('HidUsb', 'WUDFRd', 'xusb22', 'XINPUT') -or
         $_.Name -match 'controller|gamepad|joystick|xbox|gamepad')
    }

$results = foreach ($d in $devices) {
    if ($d.DeviceID -match 'VID_([0-9A-Fa-f]{4}).*PID_([0-9A-Fa-f]{4})') {
        [pscustomobject]@{
            name   = $d.Name
            vid    = $Matches[1].ToLower()
            pid    = $Matches[2].ToLower()
            source = 'powershell-wmi'
        }
    }
}

# De-duplicate on vid:pid:name (a pad can enumerate as several HID collections).
$results = $results | Sort-Object vid, pid, name -Unique

# Always emit a JSON array, even for 0 or 1 device.
ConvertTo-Json -InputObject @($results) -Compress
