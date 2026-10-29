#!/usr/bin/env bash
# shellcheck source=lib.sh
source "$(dirname "$0")/lib.sh"

case "$OS" in
Darwin) FONTS="$HOME/Library/Fonts" ;;
*) FONTS="$HOME/.local/share/fonts" ;;
esac

if ! have curl || ! have unzip; then
    echo "need curl and unzip; skipping fonts"
    exit 0
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

fetch_zip() { # name url
    local name="$1" url="$2" dest="$FONTS/$1"
    if compgen -G "$dest/*.ttf" >/dev/null; then
        echo "$name: already installed"
        return 0
    fi
    mkdir -p "$dest" "$tmp/$name"
    curl -fsSL -o "$tmp/$name.zip" "$url" &&
        unzip -oq "$tmp/$name.zip" -d "$tmp/$name" &&
        find "$tmp/$name" -name '*.ttf' -exec cp {} "$dest/" \; ||
        FAILED+=("$name")
}

fetch_file() { # name url
    local dest="$FONTS/comic"
    [ -f "$dest/$1" ] && {
        echo "$1: already installed"
        return 0
    }
    mkdir -p "$dest"
    curl -fsSL -o "$dest/$1" "$2" || {
        rm -f "$dest/$1"
        FAILED+=("$1")
    }
}

fetch_file ComicMono.ttf https://dtinth.github.io/comic-mono-font/ComicMono.ttf
fetch_file ComicMono-Bold.ttf https://dtinth.github.io/comic-mono-font/ComicMono-Bold.ttf
fetch_zip inconsolata https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/InconsolataLGC.zip
fetch_zip hack https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip

have fc-cache && fc-cache -f
finish
