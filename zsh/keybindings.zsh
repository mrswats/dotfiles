bindkey -d

zmodload zsh/complist

WIDGETS=(
    forgit::add
    forgit::diff
    forgit::log
    forgit::checkout::branch
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
bindkey "^G^Y" forgit::add
bindkey "^G^U" forgit::diff
bindkey "^G^I" forgit::log
bindkey "^G^G" forgit::checkout::branch

bindkey '^ ' autosuggest-accept
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^N' down-history
bindkey '^O' accept-line
bindkey '^P' up-history
