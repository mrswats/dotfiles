#!/usr/bin/zsh

function dots() {
    tmux new-window -c "$DOTFILES"
}

function public-ip() {
    local PUBLIC_IP=$(curl -sL v4.ifconfig.co | awk '{ print $0 "/32" }')
    echo $PUBLIC_IP
}

function src() {
    exec zsh
}

function owl() {
    echo
    echo "{o,o}"
    echo "./)_)"
    echo '  ""'
    echo
}

function kitty-cat() {
    echo ""
    echo '  /\___/\'
    echo " ( o   o )"
    echo " (  =^=  )"
    echo " (        )"
    echo " (         )"
    echo " (          )))))))))))"
    echo ""
}

function search() {
    search_string="https://duckduckgo.com/?q="

    for word in $*; do
        search_string+="${word}+"
    done

    open $search_string
}
