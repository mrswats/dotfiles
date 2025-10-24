fzf-choose-dir() {
    TARGET_DIR=$(
        z | awk '{print $2}' |
            fzf \
                --tac \
                --header "Select a directory" \
                --preview 'eza --icons -T -L 1 --group-directories-first --git --git-ignore --colour=always {+1}' \
                --query="$1" \
                --exit-0
    )
    test "$TARGET_DIR" && echo "$TARGET_DIR"
}

fzf-open-file-in-editor() {
    TARGET_FILE=($(
        fd -t f -L -H -E .git/ |
            fzf \
                --header "Select a file" \
                --preview 'bat --number --color=always --paging never {+1}' \
                --query="$1" \
                --multi \
                --select-1 \
                --exit-0
    ))
    test "$TARGET_FILE" && "${EDITOR}" "${TARGET_FILE[@]}"
    zle reset-prompt
}

fzf-new-window-choose-dir() {
    TARGET_DIR="$(fzf-choose-dir)"
    test "$TARGET_DIR" && tmux new-window -c "$TARGET_DIR"
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
    local match
    match=$(
        rg \
            --trim \
            --no-heading \
            . |
            fzf \
                --header "Search the contents" \
                --preview '
                    LINE=$(echo '{}' | cut -d ":" -f 2);
                    OFFSET=12
                    PREVIEW_LINE=$(( $LINE-$OFFSET < 0 ? 0 : $LINE-$OFFSET ))
                    FILENAME=$(echo '{}' | cut -d ":" -f 1)
                    bat $FILENAME \
                    --highlight-line $LINE \
                    --style full \
                    --color=always \
                    --line-range $PREVIEW_LINE:+$(( $OFFSET * 2 ))'
    )

    test ${match} &&
        $EDITOR $(__file_name $match) +$(__line_number $match)
}
