#!/usr/bin/bash

# shellcheck disable=SC1090
source "$HOME/.zshenv"

xrandr --output "$EXTERNAL_MONITOR" --primary --auto --output "$MAIN_SCREEN" --off
