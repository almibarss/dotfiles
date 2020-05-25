#!/usr/bin/env bash

set -euo pipefail

source ~/.dotfiles/scripts/core/utils.sh
source ~/.dotfiles/scripts/core/colors.sh

GIT_LOCAL_CONFIG="${HOME}/.dotfiles/local/gitconfig"

is_git_prop_set() {
	git config --get $1 &>/dev/null
}

if is_git_prop_set user.email; then
	echo "Your Git email is $(git config --get user.email)"
else
	if is_tty stdin; then
		read -ep "🦑 Git config: What's your email? " git_email
		git config --file "$GIT_LOCAL_CONFIG" user.email "$git_email"
	else
		echo "Please set your git email as follows:"
		echo "$ git config --global user.email 'Your email'"
	fi
fi

if is_git_prop_set user.name; then
	echo "Your Git user name is $(git config --get user.name)"
else
	if is_tty stdin; then
		read -ep "🐙 Git config: And your name? " git_name
		git config --file "$GIT_LOCAL_CONFIG" user.name "$git_name"
	else
		echo "Please set your git name as follows:"
		echo "$ git config --global user.name 'Your name'"
	fi
fi
