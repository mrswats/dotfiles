#!/usr/bin/env bash
# shellcheck source=lib.sh
source "$(dirname "$0")/lib.sh"
clone_or_update https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" || FAILED+=(tpm)
clone_or_update https://github.com/zpm-zsh/zpm "$HOME/.local/share/zpm" || FAILED+=(zpm)
finish
