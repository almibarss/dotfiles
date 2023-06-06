#!/usr/bin/env bash

set -eo pipefail

source ~/.dotfiles/scripts/core/utils.sh
source ~/.dotfiles/scripts/core/log.sh

install_latest_java() {
	section "☕Install java"
	eval "$(/opt/homebrew/bin/brew shellenv)"
	SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
	source "${SDKMAN_DIR}/bin/sdkman-init.sh"
	if sdk install java; then
		section "> java _OK_"
	else
		section "> java _FAILED_"
		return 1
	fi
}

install_latest_java
