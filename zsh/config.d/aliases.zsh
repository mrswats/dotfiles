# Terminal stuff
alias sd='sudo '
alias sv='sudo nvim'
if $(which exa &> /dev/null); then
    alias ls='exa'
    alias ll='exa --icons --long --git'
    alias lt='exa --icons --tree --git-ignore'
    alias lr='exa --icons --long --git --sort time'
else
    alias ls='ls --color=auto'
    alias ll='ls -lsF'
fi
if $(which bat &> /dev/null); then
    alias cat='bat --theme base16'
fi
alias less='less -r'
alias untar='tar xvfz'

alias v='nvim'
alias vim='nvim'
alias edit='nvim'

alias dot='cd ${DOTFILES:-$HOME/.dotfiles}'

# Assign these file extensions to neovim
extensions=(py yaml yml cfg md rst txt json rs)
for ext in $extensions; do
    alias -s $ext=nvim
done

alias -s html=firefox
