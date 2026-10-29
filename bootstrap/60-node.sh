#!/usr/bin/env bash
# shellcheck source=lib.sh
source "$(dirname "$0")/lib.sh"
DIR="$(cd "$(dirname "$0")" && pwd)"
have npm || {
    echo "npm not installed; skipping"
    exit 0
}
have yarn || npm install -g --prefix "$HOME/.local" yarn
have yarn || {
    echo "yarn still missing"
    exit 1
}
install_each "yarn global add --prefix $HOME/.local" "$DIR/yarn.list"
finish
