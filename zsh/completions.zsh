# Completions for varied CLI programs

autoload -Uz compinit
compinit

# Completion Menu like OMZ
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true

if [[ "$(command -v heroku)" ]]; then
    HEROKU_AC_ZSH_SETUP_PATH=$HOME/Library/Caches/heroku/autocomplete/zsh_setup &&
        test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH
fi
