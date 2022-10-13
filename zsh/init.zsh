# local Variables
LOCAL_SHARE="$HOME/.local/share"
LOCAL_BIN="$HOME/.local/bin"
CUSTOM_MODULES="$DOTFILES/zsh/modules"
FORGIT_INSTALL_DIR="$ANTIGEN_BUNDLES/wfxr/forgit"

BIN_PATH=(
    "$LOCAL_BIN"
    "$CARGO_HOME/bin"
    "$GOPATH/bin"
    "$LOCAL_SHARE/kew/bin"
    "$HOME/.luarocks/bin"
    "$FORGIT_INSTALL_DIR/bin"
    "$FLYCTL_INSTALL/bin"
)

F_PATH=("$LOCAL_SHARE/zfunc" "$HOME/.cache/zsh")

# Load custom modules
for module ($CUSTOM_MODULES/*.zsh) source $module

for new_path in "${BIN_PATH[@]}"; do
    [[ -d "$new_path" ]] && path+="$new_path"
done

for new_path in "${F_PATH[@]}"; do
    [[ -d "$new_path" ]] && fpath+="$new_path"
done

# vi: ft=zsh
