#!/usr/bin/env bash

set -euo pipefail

source ~/.dotfiles/scripts/core/utils.sh
source ~/.dotfiles/scripts/core/log.sh

SDKMAN_URL="https://get.sdkman.io?rcupdate=false"
SDKMAN_DIR="/usr/local/sdkman"

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
		chown -R $USER $SDKMAN_DIR
		source "${SDKMAN_DIR}/bin/sdkman-init.sh"
		section "> sdkman _OK_ # $(sdkman_version)"
	else
		section "> sdkman _FAILED_"
	fi
}

install_sdkman
