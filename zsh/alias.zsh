alias v='vim'
alias l='ls'
alias ll='ls -l'
alias la='ls -la'
alias ..='cd ..'

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
	alias gl='git log'
	alias gla='git log --graph'
	alias gs='git status --short --branch'
	alias gr='git reset'
	alias grh='git reset --hard'
	alias gpus='git push'
	alias gpusu='git push -u'
	alias gpusf='git push -f'
	alias gpul='git pull'
fi

alias rg=tag

# Global aliases

alias -g If='| fzf'
alias -g Ib='| bat'
