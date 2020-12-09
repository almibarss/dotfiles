#!/usr/bin/env bash

set -euo pipefail

source ~/.dotfiles/scripts/core/utils.sh
source ~/.dotfiles/scripts/core/log.sh

SDKMAN_URL="https://get.sdkman.io?rcupdate=false"
SDKMAN_DIR="/usr/local/sdkman"
SUBLIME_NORD_THEME_URL="https://raw.githubusercontent.com/arcticicestudio/nord-sublime-text/ed99ad15e5b8fc5c4b97aaa312a828f1fc6ad09f/Nord.tmTheme"

sdkman_version() {
	echo $SDKMAN_VERSION
}

install_sdkman() {
	if [[ -d $SDKMAN_DIR ]]; then
		section "> sdkman _SKIPPED_ # $(sdkman_version)"
		return 0
	fi

	section "📦  Install sdkman"
	echo "🌎  $SDKMAN_URL"
	export SDKMAN_DIR
	if exec_remote $SDKMAN_URL bash-with-sudo; then
		sudo chown -R $USER $SDKMAN_DIR
		source "${SDKMAN_DIR}/bin/sdkman-init.sh"
		section "> sdkman _OK_ # $(sdkman_version)"
	else
		section "> sdkman _FAILED_"
	fi
}

install_nord_theme_for_bat() {
	echo "Install Nord theme for bat..."
	local tmpdir themes_dir
	tmpdir="$(mktemp -d)"
	themes_dir="${tmpdir}/themes"

	mkdir -p "$themes_dir"
	(cd "$themes_dir" && curl -sL --remote-name $SUBLIME_NORD_THEME_URL)

	bat cache --build --source "${tmpdir}"

	rm -rf "${tmpdir}"
}

install_sdkman
install_nord_theme_for_bat
