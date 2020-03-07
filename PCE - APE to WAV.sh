#!/bin/bash

find . -name "*.ape" -exec bash -c 'ffmpeg -y -i "$1" "${1%.ape}".wav' - '{}' \;

#for /r %%i in (*.ape) do ffmpeg.exe -y -i "%%i" -o "%%~ni.wav"
