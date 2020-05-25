#!/usr/bin/env bash

set -euo pipefail

source ~/.dotfiles/scripts/core/utils.sh
source ~/.dotfiles/scripts/core/log.sh

case $(os_type) in
	unknown)
		error "Unable to identify your OS!"
		;;
	ubuntu)
		os_name
		~/.dotfiles/linux/ubuntu/install.sh
		;;
	macos)
		os_name
		~/.dotfiles/macos/install.sh
		;;
	*)
		section "$(os_name) _SKIPPED_"
		;;
esac
