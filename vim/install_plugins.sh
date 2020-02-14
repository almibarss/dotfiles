#!/usr/bin/env bash

set -euo pipefail

source ~/.dotfiles/scripts/core/utils.sh
source ~/.dotfiles/scripts/core/log.sh

VIM_PLUG_PATH="${HOME}/.dotfiles/modules/vim-plug/autoload/plug.vim"
PLUGINS_DIR="${HOME}/.dotfiles/modules/vim-plug/modules"

vim_version() {
	vim --version | head -1 | cut -d' ' -f5-
}

check_vim() {
	if ! has vim; then
		section "> vim _MISSING_"
		return 1
	fi

	section "> vim _OK_ # $(vim_version)"
}

install_plugins() {
	if [[ -d $PLUGINS_DIR ]]; then
		section "> plugins _SKIPPED_"
		return 0
	fi

	section "📦  Install plugins"
	vim \
		"+so $VIM_PLUG_PATH" \
		"+so ${XDG_CONFIG_HOME:-${HOME}/.config}/vim/plugins.vim" \
		"+let g:plug_window='vertical topleft'" \
		"+PlugInstall" \
		"+echo 'Installation done! (exiting after 2s)'" \
		"+2sleep" \
		"+qa"
	section "> plugins _OK_"
	echo "Manage vim plugins with 'dot vim plugins'"
}

check_vim && install_plugins
