fzf-choose-dir() {
    local target_dir=$(z \
        | fzf \
        --border-label "Sel·lecciona un directori"\
        --nth 2.. --tac --no-sort --accept-nth 2.. \
        --preview 'echo -e "Sel·lecciont {+2..}\n";eza --color=always --icons --long --git {+2..}' \
    ) && echo $target_dir
}

fzf-open-file-in-editor() {
    fd -t f -L -H -E .git/ \
        | fzf \
        --border-label "Sel·lecciona un fitxer" \
        --tac --no-sort \
        --preview 'bat --color always {}' \
        --bind 'enter:become(nvim {})'
}

fzf-new-window-choose-dir() {
    local target_dir=$(fzf-choose-dir) \
        && test $target_dir \
        && tmux new-window -c "$target_dir"
    zle reset-prompt
}

fzf-cd-to-dir() {
    zle push-line
    TARGET_DIR="$(fzf-choose-dir)"
    test "$TARGET_DIR" && cd "$TARGET_DIR"
    zle reset-prompt
}

__file_name() {
    echo "$1" | cut -d ":" -f 1
}

__line_number() {
    echo "$1" | cut -d ":" -f 2
}

fzf-open-file-from-contents() {
    # Source: https://github.com/junegunn/fzf/wiki/Examples#searching-file-contents
    local match=$(
        rg \
        --trim --no-heading --color never . | \
        fzf \
        --border-label "Busca en els continguts" \
        --preview \
        'LINE=$(echo '{}' | cut -d ":" -f 2);
        OFFSET=12
        PREVIEW_LINE=$(( $LINE-$OFFSET < 0 ? 0 : $LINE-$OFFSET ))
        FILENAME=$(echo '{}' | cut -d ":" -f 1)
        bat $FILENAME \
        --highlight-line $LINE \
        --style full \
        --color=always \
        --line-range $PREVIEW_LINE:+$(( $OFFSET * 4 ))'
    )

    test ${match} &&
        $EDITOR $(__file_name $match) +$(__line_number $match)
}
