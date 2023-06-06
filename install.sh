#!/usr/bin/env bash
# use: bash <(curl -sL git.io/mperezi.dots)

set -euo pipefail

DOTFILES_CLONE_URL="https://github.com/almibarss/dotfiles.git"
DOTFILES_PUSH_URL="git@github.com:almibarss/dotfiles.git"
DOTFILES_HOME=${DOTFILES_HOME:-~/.dotfiles}
DOTBOT_DIR="modules/dotbot"
DOTBOT_BIN="bin/dotbot"

main() {
  has git && has curl ||
    abort "Please install git and curl before running the installer"

  echo "DOTFILES_HOME=$DOTFILES_HOME"
  echo

  setup_sudo
  check_deps
  check_installation

  export DOTFILES_HOME
  export XDG_CONFIG_HOME=~/.config
  export XDG_CACHE_HOME=~/.cache
  export XDG_DATA_HOME=~/.local/share


  echo "🤖 Dotfiles powered by dotbot"
  "${DOTFILES_HOME}/${DOTBOT_DIR}/${DOTBOT_BIN}" \
    --base-directory "$DOTFILES_HOME" \
    --config-file "${DOTFILES_HOME}/install.conf.yaml" \
    ${DOTFILES_NO_COLOR:+"--no-color"} &&
    congratulations
}

setup_sudo() {
  echo "⚠️ The script enables passwordless sudo for unattended installation"
  sudo sh -c "echo \"$(whoami)\t\tALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers"
}

check_deps() {
  ! [[ $(os_type) == macos ]] && return

  echo "MacOS detected. Installing required Command Line Tools for XCode..."
  # https://apple.stackexchange.com/a/195963
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  local -r cli_update=$(softwareupdate -l |
    grep '^*' |
    cut -d: -f2 |
    grep -i 'command line' |
    sort -r |
    head  -n1 |
    xargs)

  [[ -n $cli_update ]] || abort "Command Line Tools update not found. Please install manually"

  echo "Update found: $cli_update"
  softwareupdate -i "$cli_update" --verbose
  rm -f /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
}

check_installation() {
	if [[ ! -d $DOTFILES_HOME ]]; then
    echo
		echo "🚀 First time install"
    echo
		clone_repo || abort "Failed to clone repo"
	elif already_cloned; then
		echo "🔍 Installation found"
		"${DOTFILES_HOME}/bin/dot" update
	else
		abort "$DOTFILES_HOME already exists"
	fi
}

clone_repo() {
	local clone_options="--depth 1 --recurse-submodules --shallow-submodules"
	git clone $clone_options "$DOTFILES_CLONE_URL" "$DOTFILES_HOME"
  # we change the remote URL so that we can push later on using a public key
  (cd $DOTFILES_HOME && git remote set-url origin $DOTFILES_PUSH_URL)
}

already_cloned() {
	(cd "$DOTFILES_HOME" && [[ $(git remote get-url origin) == $DOTFILES_PUSH_URL ]]) &>/dev/null
}

congratulations() {
	source ~/.dotfiles/scripts/core/colors.sh
	set_colors stdout

	echo
	echo -n "$BLUE"
	echo "┌──────────────────────────────────┐"
	echo "│       🎉 You're all set!         │"
	echo "└──────────────────────────────────┘"
	echo -n "$RESET"
}
has() {
	# https://stackoverflow.com/a/26759734
	[[ -x $(command -v $1) ]]
}

abort() {
	echo "Error: $1" >&2
	exit 1
}

os_type() {
	case $(uname -s) in
		Linux)  linux_flavor;;
		Darwin) echo "macos";;
		*)      echo "unknown";;
	esac
}

main "$@"
