#!/usr/bin/env bash

set -euo pipefail

ZIM_HOME=~/.dotfiles/modules/zimfw

source ~/.dotfiles/scripts/core/utils.sh
source ~/.dotfiles/scripts/core/log.sh
source ~/.dotfiles/scripts/core/colors.sh

zsh_version() {
	zsh --version | awk 'NR==1 {print $2}'
}

check_zsh() {
	if ! has zsh; then
		section ">  zsh _MISSING_"
		return 1
	fi

	section "> zsh _OK_ # $(zsh_version)"
}

zimfw_version() {
	zsh "${ZIM_HOME}/zimfw.zsh" info 2>/dev/null | awk -F: '/^zimfw version/{print $2}' | sed 's,^ *,,'
}

check_zimfw() {
	if [[ -f ${ZIM_HOME}/init.zsh ]]; then
		section "> zimfw _SKIPPED_ # $(zimfw_version)"
		return 0
	fi

	section "📦 Install zimfw"

	if zsh "${ZIM_HOME}/zimfw.zsh" install; then
		section "> zimfw _OK_ # $(zimfw_version)"
		echo "Manage zsh plugins with 'dot zsh plugins'"
	else
		section "> zimfw _FAILED_"
	fi
}

check_default_shell() {
	if [[ ! ${SHELL:-unknown} =~ /zsh$ ]]; then
		if is_tty stdin && has chsh; then
			echo "Setting zsh as your default shell"
			chsh -s $(command -v zsh)
		else
			echo "Set zsh as your default shell:"
			echo "$ chsh -s $(command -v zsh)"
		fi
	fi
}

if check_zsh; then
	check_zimfw
	check_default_shell
fi
