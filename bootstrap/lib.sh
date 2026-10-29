set -uo pipefail

# shellcheck disable=SC2034
OS="$(uname -s)"
FAILED=()

have() { command -v "$1" >/dev/null 2>&1; }
log() { printf '\n==> %s\n' "$*"; }

# Locate Homebrew and put it on PATH for this process
load_brew() {
    have brew && return 0
    local p
    for p in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
        if [ -x "$p" ]; then
            eval "$("$p" shellenv)"
            return 0
        fi
    done
    return 1
}

# Tools installed into the home directory
export CARGO_HOME="$HOME/.local/share/cargo"
export RUSTUP_HOME="$HOME/.local/share/rustup"
export PATH="$HOME/.local/bin:$CARGO_HOME/bin:$PATH"
load_brew || true

# Print list entries, skipping blank lines and # comments
read_list() { grep -v -e '^[[:space:]]*#' -e '^[[:space:]]*$' "$1" 2>/dev/null || true; }

# install_each "<install command>" file
# Runs the command once per entry; failures are recorded, not fatal.
# Uses fd 3 so the command can't swallow the rest of the list via stdin.
install_each() {
    local cmd="$1" list="$2" pkg
    while read -r pkg <&3; do
        echo "  -> $pkg"
        # shellcheck disable=SC2086
        $cmd "$pkg" || FAILED+=("$pkg")
    done 3< <(read_list "$list")
}

# Idempotent clone/update
clone_or_update() {
    local url="$1" dest="$2"
    if [ -d "$dest/.git" ]; then
        git -C "$dest" pull --ff-only --quiet && git -C "$dest" submodule update --init --recursive --quiet
    else
        mkdir -p "$(dirname "$dest")"
        git clone --recurse-submodules "$url" "$dest"
    fi
}

finish() {
    if [ "${#FAILED[@]}" -gt 0 ]; then
        printf '\n!! Failed:\n'
        printf '   - %s\n' "${FAILED[@]}"
        exit 1
    fi
}
