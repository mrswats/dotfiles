#!/usr/bin/env bash
# shellcheck source=lib.sh
source "$(dirname "$0")/lib.sh"
have starship && {
    echo "starship already installed"
    exit 0
}
mkdir -p "$HOME/.local/bin"
curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"
