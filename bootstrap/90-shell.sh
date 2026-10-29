#!/usr/bin/env bash
# shellcheck source=lib.sh
source "$(dirname "$0")/lib.sh"

zsh_path="$(command -v zsh)" || {
    echo "zsh not installed; skipping"
    exit 0
}
current="$(getent passwd "$USER" 2>/dev/null | cut -d: -f7)"
current="${current:-$SHELL}"
[ "$current" = "$zsh_path" ] && {
    echo "zsh already the login shell"
    exit 0
}

grep -qx "$zsh_path" /etc/shells || echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null

if have chsh; then
    chsh -s "$zsh_path"
else
    sudo usermod -s "$zsh_path" "$USER"
fi
