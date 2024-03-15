alias ..='cd ..'
alias ...='cd ../..'
alias mv='mv -v'
alias cp='cp -v'
alias ln='ln -v'
alias rm='rm -v'

export EDITOR=nvim
export PATH="${HOME}/.dotfiles/bin:/usr/local/bin:$PATH"

# XDG setup
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
