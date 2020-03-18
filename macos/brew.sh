#!/usr/bin/env bash

set -euo pipefail

source ~/.dotfiles/scripts/core/utils.sh
source ~/.dotfiles/scripts/core/log.sh

BREW_URL="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"
BREWFILE="~/.dotfiles/macos/Brewfile"

brew_version() {
	brew --version | awk 'NR == 1'
}

install_packages() {
	section "📦  Brew bundle"
	if brew bundle --file=$BREWFILE; then
		section "> Brewfile _OK_"
	else
		section "> Brewfile _FAILED_"
		return 1
	fi
}

check_brew() {
	if has brew; then
		section "> brew _SKIPPED_ # $(brew_version)"
		return 0
	fi

	section "📦  Install brew"
	echo "🌎  $BREW_URL"
	if exec_remote $BREW_URL; then
		section "> brew _OK_ # $(brew_version)"
	else
		section "> brew _FAILED_"
		return 1
	fi
}

check_brew && install_packages
