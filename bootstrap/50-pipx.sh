#!/usr/bin/env bash
# shellcheck source=lib.sh
source "$(dirname "$0")/lib.sh"
DIR="$(cd "$(dirname "$0")" && pwd)"

VENV="$HOME/.local/share/pipx-venv"
BIN="$HOME/.local/bin"

have python3 || {
    echo "python3 not found; skipping pipx"
    exit 0
}

# (Re)create the venv if it's missing or broken (e.g. after a system Python upgrade)
if ! "$VENV/bin/python" -c 'import sys' >/dev/null 2>&1; then
    log "creating pipx venv"
    rm -rf "$VENV"
    python3 -m venv "$VENV" || {
        echo "venv creation failed (is the python venv module installed?)"
        exit 1
    }
fi

log "installing/upgrading pipx"
"$VENV/bin/python" -m pip install --quiet --upgrade pip pipx || exit 1

mkdir -p "$BIN"
ln -sf "$VENV/bin/pipx" "$BIN/pipx"

have pipx || {
    echo "pipx not on PATH after linking"
    exit 1
}
install_each "pipx install" "$DIR/pipx.list"
finish
