alias v='vim'
alias l='ls'
alias ll='ls -l'
alias la='ls -la'
alias ..='cd ..'
alias mv='mv -v'
alias cp='cp -v'
alias ln='ln -v'
alias rm='rm -v'

if has exa; then
	alias ls='exa'
	alias t1='exa -L 2 -T'
	alias t2='exa -L 3 -T'
fi

if has docker; then
	alias db='docker build'
	alias dr='docker run --rm -it'
	alias de='docker exec -it'
fi

if has git; then
	alias gc='git commit'
	alias gcm='git commit -m'
	alias gca='git commit --amend'
	alias gcane='git commit --amend --no-edit'
	alias gcl='git clone'
	alias ga='git add'
	alias gau='git add -u'
	alias gri='git rebase -i'
	alias grc='git rebase --continue'
	alias gra='git rebase --abort'
	alias gmc='git merge --continue'
	alias gma='git merge --abort'
	alias gl='git log'
	alias gs='git status --short --branch'
	alias gr='git reset'
	alias grh='git reset --hard'
	alias gpus='git push'
	alias gpusnv='git push --no-verify'
	alias gpusu='git push -u'
	alias gpusf='git push -f'
	alias gpul='git pull'
	alias gsw='git switch'
	alias gcb='git switch -c'
	alias gdc='git df --cached'
fi

alias rg=tag

# Global aliases

alias -g If='| fzf'
alias -g Ib='| bat'
