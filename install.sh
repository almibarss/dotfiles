#!/usr/bin/env bash
# use: bash <(curl -sL git.io/mperezi.dots)

set -euo pipefail

DOTFILES_URL="https://github.com/mperezi/dotfiles.git"
DOTFILES_HOME=${DOTFILES_HOME:-~/.dotfiles}
DOTBOT_DIR="modules/dotbot"
DOTBOT_BIN="bin/dotbot"

has() {
	# https://stackoverflow.com/a/26759734
	[[ -x $(command -v $1) ]]
}

abort() {
	echo "Error: $1" >&2
	exit 1
}

check_installation() {
	if [[ ! -d $DOTFILES_HOME ]]; then
		echo "🚀  First time install"
		clone_repo || abort "Failed to clone repo"
	elif already_cloned; then
		echo "🔍  Installation found"
		"${DOTFILES_HOME}/bin/dot" update
	else
		abort "$DOTFILES_HOME already exists"
	fi
}

clone_repo() {
	git clone \
		--depth 1 \
		--recurse-submodules \
		--shallow-submodules \
		"$DOTFILES_URL" "$DOTFILES_HOME"
}

already_cloned() {
	(cd "$DOTFILES_HOME" && [[ $(git remote get-url origin) == $DOTFILES_URL ]]) &>/dev/null
}

congratulations() {
	source ~/.dotfiles/scripts/core/colors.sh
	set_colors stdout

	echo
	echo -n "$BLUE"
	echo "┌──────────────────────────────────┐"
	echo "│       🎉  You're all set!         │"
	echo "└──────────────────────────────────┘"
	echo -n "$RESET"
}


has git && has curl ||
	abort "Please install git and curl before running the installer"

echo "DOTFILES_HOME=$DOTFILES_HOME"
echo

check_installation

export DOTFILES_HOME
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share

echo "🤖  Dotfiles powered by dotbot"
"${DOTFILES_HOME}/${DOTBOT_DIR}/${DOTBOT_BIN}" \
	--base-directory "$DOTFILES_HOME" \
	--config-file "${DOTFILES_HOME}/install.conf.yaml" \
	${DOTFILES_NO_COLOR:+"--no-color"} &&
	congratulations
