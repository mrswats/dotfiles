#!/usr/bin/env bash
# shellcheck source=lib.sh
source "$(dirname "$0")/lib.sh"
DIR="$(cd "$(dirname "$0")" && pwd)"

if have brew; then
    log "brew packages"
    brew update || true
    install_each "brew install" "$DIR/brewfile"
elif have dnf; then
    log "dnf packages"
    mapfile -t pkgs < <(read_list "$DIR/dnf.list")
    # Fast path: one transaction. Fallback: one at a time so a single bad name doesn't sink the rest.
    if ! sudo dnf install -y "${pkgs[@]}"; then
        echo "Bulk install failed; retrying per package"
        install_each "sudo dnf install -y" "$DIR/dnf.list"
    fi
    sudo dnf group install -y "Development Tools" || sudo dnf group install -y development-tools || FAILED+=("Development Tools")
else
    echo "No supported package manager found"
fi
finish
