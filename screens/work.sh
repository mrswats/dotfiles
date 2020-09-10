#!/usr/bin/bash

# shellcheck disable=SC1090
source "$HOME/.zshenv"

xrandr --output "$MAIN_SCREEN" --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
    --output "$EXTERNAL_MONITOR" --mode 1920x1080 --right-of "$MAIN_SCREEN" --rotate normal
