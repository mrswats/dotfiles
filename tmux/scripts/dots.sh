#!/usr/bin/env bash

current=$(tmux display-message -p '#S')
echo $(tmux list-sessions -F "#{?#{==:#{session_name},$current},●,○}")
