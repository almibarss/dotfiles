alias vi='vim'
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
	alias gl='git lg'
	alias gs='git status --short --branch'
fi

alias rg=tag

# Global aliases

alias -g If='| fzf'
alias -g Ib='| bat'
