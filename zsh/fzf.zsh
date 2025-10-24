# Settings and functions for FZF

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd'

# Default options for all fzf calls
export FZF_DEFAULT_OPTS="--ansi --reverse --border --height 80% --exact --preview-window=right:50%"

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# source: https://junegunn.kr/2016/07/fzf-git/
is-in-git-repo() {
    git rev-parse --is-inside-work-tree &>/dev/null
}

gr() {
    is-in-git-repo || return
    git restore $(
        git ls-files --modified |
            fzf \
                --header "Select a file" \
                -m \
                --preview 'git diff {+1} | delta'
    )
}


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
