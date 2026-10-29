#!/usr/bin/env bash
# shellcheck source=lib.sh
source "$(dirname "$0")/lib.sh"
DIR="$(cd "$(dirname "$0")" && pwd)"

if ! have rustup; then
    curl --proto '=https' --tlsv1.2 -fsSL https://sh.rustup.rs | sh -s -- -y --no-modify-path || exit 1
fi
have cargo || {
    echo "cargo not found after rustup"
    exit 1
}
install_each "cargo install" "$DIR/cargo.list"
finish
