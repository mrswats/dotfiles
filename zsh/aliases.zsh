alias please='sudo'
alias prettyplease='sudo !!'
alias less='less -r'
alias untar='tar xvfz'
alias c='clear'
alias copy='xsel -i --clipboard' # Meant to use it as a pipe
alias cd-='cd -'
alias e="\$EDITOR --noplugins"
alias v="\$EDITOR"
alias vim="\$EDITOR"
alias m=make
alias open='xdg-open'

alias mv='mv -v'
alias cp='cp -v'
alias mkdir='mkdir -pv'

alias -s html="\$BROWSER"

[ "$(command -v bat)" ] && alias cat='bat'
[ "$(command -v ggrep)" ] && alias grep='ggrep'
[ "$(command -v awshelp)" ] && alias aws=awshelp
[ "$(command -v nitrogen)" ] && alias wallpaper='nitrogen --restore'

if [ "$(command -v eza)" ]; then
    alias ls='eza'
    alias ll='eza --icons --long --git'
    alias lt='eza --icons --tree --git-ignore'
    alias lr='eza --icons --long --git --sort time'
else
    alias ls='ls --color=auto'
    alias ll='ls -lsF'
fi

if [ "$(command -v Obsidian)" ]; then
    alias obsidian='Obsidian &>/dev/null&; disown'
fi

if [ "$(command -v dnf)" ]; then
    alias dnfl='dnf list'
    alias dnfli='dnf list installed'
    alias dnfp='dnf info'
    alias dnfs='dnf search'
    alias dnfw='dnf whatprovides'
    alias dnfu='sudo dnf update'
    alias dnfy='sudo dnf update -y'
    alias dnfi='sudo dnf install'
    alias dnfyy='sudo dnf install -y'
    alias dnfr='sudo dnf remove'
fi

alias tf=terraform

if [ "$(command -v kubectl)" ]; then
    alias kn='kubectl ns'
    alias kx='kubectl ctx'
    alias kg='kubectl get'
    alias ka='kubectl apply'
    alias kc='kubectl create'
    alias kd='kubectl delete'
    alias ke='kubectl edit'
    alias ks='kubectl describe'
    alias krr='kubectl rollout restart'
    alias krs='kubectl rollout status'
    alias kwd='k9s --context dev-izi-compute-cluster'
    alias kws='k9s --context staging-izi-compute-cluster'
    alias kwp='k9s --context prod-izi-compute-cluster'
fi

alias local-ip='python -c "import socket; print(socket.gethostbyname(socket.gethostname()))"'

alias gst='git status'
alias gc='git commit -v'
alias gcnv='git commit -v --no-verify'
alias gca='git commit -v --amend'
alias 'gcan!'='git commit -v --amend --no-edit'
alias fixup='git fixup'
alias gclean='git clean -fd'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gb='git branch'
alias gu='git undo'
alias gus='git undo --soft'
alias gu1s='git undo 1 --soft'
alias gdc='git forgit diff --cached'
alias gdh='git diff HEAD^!'
alias gshd='gsh develop..HEAD'
alias gf='git fetch --prune'
alias gl='git down'
alias gcl='git clone'
alias gswm='git switch main'
alias gswd='git switch develop'
alias gsw-='git switch -'
alias gswt='git switch --track'
alias grs='git forgit reset_head'
alias gra='git restore .'
alias grsa='git restore --staged .'
alias glob="git lob"
alias glom="git lom"
alias glol="git lol"
alias glos="git los"
alias glast="git last"
alias WIP='git wip'
alias gbrs='git branches'
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gp='git push'
alias gpt='git push --follow-tags'
alias 'gpf!'='git push --force-with-lease'
alias gpub='git publish'
alias grb='git rebase'
alias grbd='git rebase develop'
alias grbm='git rebase main'
alias grbda="git rebase develop --autosquash"
alias grbma="git rebase main --autosquash"
alias grbi='git rebase --interactive'
alias grbid='git rebase --interactive develop'
alias grbim='git rebase --interactive main'
alias grbia='git rebase --interactive --autosquash'
alias grbida='git rebase --interactive --autosquash develop'
alias grbima='git rebase --interactive --autosquash main'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbe='git rebase --edit'
alias grm='git rm'
alias gmv='git mv'
alias gcp='git forgit cherry_pick'
alias gcpc='git cherry-pick --continue'
alias gcpa='git cherry-pick --abort'
alias gsta='git stash push'
alias gstak='git stash push --keep-index'
alias gstp='git stash pop'
alias gstas='git stash show'
alias gstcl='git stash clear'

alias pd='python3 -m pytest --color yes -lvxs'
alias pa='clear; python3 -m pytest --color yes --durations=10 -qk ""'
alias pap='pa -n 4'
alias pdj='pap --cov --cov-report term-missing'
alias pdjc='pap --dov --cov-report html'

alias mkv='virtualenv .venv && source ./.venv/bin/activate'
alias rmv='deactivate && rm -rf .venv'
alias refv='deactivate && rm -rf .venv && virtualenv .venv'
alias a='source ./.venv/bin/activate'
alias d='deactivate'

alias dps='docker ps'
alias dsa='docker stop all'
