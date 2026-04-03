# ZSH Keybindings

bindkey -d

zmodload zsh/complist

WIDGETS=(
    forgit::add
    forgit::checkout::branch
    forgit::diff
    forgit::log
    fzf-cd-to-dir
    fzf-new-window-choose-dir
    fzf-open-file-from-contents
    fzf-open-file-in-editor
)

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
    git forgit checkout_branch
    zle reset-prompt
}

for widget ($WIDGETS[@]) zle -N $widget

bindkey "^G^E" fzf-open-file-in-editor
bindkey "^G^O" fzf-cd-to-dir
bindkey "^G^S" fzf-open-file-from-contents
bindkey "^G^P" fzf-new-window-choose-dir

bindkey "^G^Y" forgit::add
bindkey "^G^U" forgit::diff
bindkey "^G^I" forgit::log
bindkey "^G^G" forgit::checkout::branch

bindkey '^ ' autosuggest-accept
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^O' accept-line
bindkey '^P' up-history
bindkey '^N' down-history
