# ZSH Keybindings

bindkey -d

zmodload zsh/complist

# FZF key-bindings for fedora
test -e /etc/fedora-release && source /usr/share/fzf/shell/key-bindings.zsh

forgit-add () {
    git forgit add
    zle reset-prompt
}

forgit-diff () {
    git forgit diff
    zle reset-prompt
}

forgit-log () {
    git forgit log
    zle reset-prompt
}

forgit-switch () {
    git forigt checkout_branch
    zle reset-prompt
}

WIDGETS=(
    edit-command-line
    forgit-add
    forgit-diff
    forgit-log
    forgit-switch
    fzf-cd-to-dir
    fzf-new-window-choose-dir
    fzf-open-file-from-contents
    fzf-open-file-in-editor
    src
)

for widget ($WIDGETS) zle -N $widget

bindkey "^G^E" fzf-open-file-in-editor
bindkey "^G^O" fzf-cd-to-dir
bindkey "^G^P" fzf-new-window-choose-dir
bindkey "^G^S" fzf-open-file-from-contents
bindkey "^G^Y" forgit-add
bindkey "^G^U" forgit-diff
bindkey "^G^I" forgit-log
bindkey "^G^G" forgit-switch

bindkey '^ ' autosuggest-accept
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^N' down-history
bindkey '^O' accept-line
bindkey '^P' up-history
bindkey '^X^E' edit-command-line
