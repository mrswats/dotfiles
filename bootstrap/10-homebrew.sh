#!/usr/bin/env bash
# shellcheck source=lib.sh
source "$(dirname "$0")/lib.sh"
[ "$OS" = Darwin ] || exit 0
load_brew && {
    echo "Homebrew already installed"
    exit 0
}
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
load_brew
