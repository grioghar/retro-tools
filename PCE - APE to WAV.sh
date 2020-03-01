#!/bin/bash

find . -name "*.ape" -exec bash -c 'ffmpeg -y -i "$1" "${1%.ape}".wav' - '{}' \;
