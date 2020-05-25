#!/usr/bin/env bash

source ~/.dotfiles/scripts/core/log.sh

BIN_PATH=/usr/local/bin
UBUNTU_VERSION="$(awk -F= '/^VERSION_ID=/{gsub(/"/, "", $2);print $2}' </etc/os-release)"

BAT_RELEASE_URL="https://github.com/sharkdp/bat/releases/download/v0.15.2/bat-v0.15.2-x86_64-unknown-linux-musl.tar.gz"
SUBLIME_NORD_THEME_URL="https://raw.githubusercontent.com/arcticicestudio/nord-sublime-text/ed99ad15e5b8fc5c4b97aaa312a828f1fc6ad09f/Nord.tmTheme"
RIPGREP_RELEASE_URL="https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep-11.0.2-x86_64-unknown-linux-musl.tar.gz"
TAG_RELEASE_URL="https://github.com/aykamko/tag/releases/download/v1.4.0/tag_linux_amd64.tar.gz"
FD_RELEASE_URL="https://github.com/sharkdp/fd/releases/download/v7.4.0/fd-v7.4.0-x86_64-unknown-linux-musl.tar.gz"
GIT_DELTA_RELEASE_URL="https://github.com/dandavison/delta/releases/download/0.1.1/delta-0.1.1-x86_64-unknown-linux-musl.tar.gz"


ubuntu_version_greater_or_eq() {
	[[ ! $UBUNTU_VERSION < $1 ]]
}

install_via_apt() {
	local apt_packages=(vim zsh autojump jq yamllint shellcheck)
	section "📦 Install ${apt_packages[*]}"
	${SUDO:-} apt-get -y install ${apt_packages[*]}

	if ubuntu_version_greater_or_eq 19.10; then
		${SUDO:-} apt-get -y install fzf fd-find ripgrep
	else
		install_fzf_custom
		install_fd_custom
		install_ripgrep_custom
	fi
	
	# https://github.com/sharkdp/bat/issues/938
	install_bat_custom
	install_nord_theme_for_bat
	install_git_delta_custom
	install_tag
}

install_fzf_custom() {
	section "📦 Install fzf from releases"
	
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf &&
		~/.fzf/install --bin &&
		${SUDO:-} cp ~/.fzf/bin/fzf $BIN_PATH/
	rm -rf ~/.fzf
}

install_bat_custom() {
	section "📦 Install bat from releases"
	echo "🌎 $BAT_RELEASE_URL"
	curl -sL $BAT_RELEASE_URL |
	${SUDO:-} tar xzf - \
		-C $BIN_PATH/ \
		--strip-components=1 \
		bat-v0.15.2-x86_64-unknown-linux-musl/bat
}
install_bat() {
		echo "Installing bat..."

				install_nord_theme_for_bat
			}


install_nord_theme_for_bat() {
	section "📦 Install Nord theme for bat"
	echo "🌎 $SUBLIME_NORD_THEME_URL"
	local tmpdir themes_dir
	tmpdir="$(mktemp -d)"
	themes_dir="${tmpdir}/themes"

	mkdir -p "$themes_dir"
	(cd "$themes_dir" && curl -sL --remote-name $SUBLIME_NORD_THEME_URL)

	bat cache --build --source "${tmpdir}"

	rm -rf "${tmpdir}"
}

install_ripgrep_custom() {
	section "📦 Install ripgrep from releases"
	echo "🌎 $RIPGREP_RELEASE_URL"
	curl -sL $RIPGREP_RELEASE_URL |
	${SUDO:-} tar xzf - \
		-C $BIN_PATH \
		--strip-components=1 \
		ripgrep-11.0.2-x86_64-unknown-linux-musl/rg
}

install_git_delta_custom() {
	section "📦 Install git-delta from releases"
	echo "🌎 $GIT_DELTA_RELEASE_URL"
	curl -sL $GIT_DELTA_RELEASE_URL |
	${SUDO:-} tar xzf - \
		-C $BIN_PATH \
		--strip-components=1 \
		delta-0.1.1-x86_64-unknown-linux-musl/delta
}

install_tag() {
	section "📦 Install tag-ag from releases"
	echo "🌎 $TAG_RELEASE_URL"
	curl -sL $TAG_RELEASE_URL |
	${SUDO:-} tar xzf - \
		-C $BIN_PATH tag
}

install_fd_custom() {
	section "📦 Install fd from releases"
	echo "🌎 $FD_RELEASE_URL"
	curl -sL $FD_RELEASE_URL |
	${SUDO:-} tar xzf - \
		-C $BIN_PATH \
		--strip-components=1 \
		fd-v7.4.0-x86_64-unknown-linux-musl/fd
}

[[ $(whoami) != root ]] && SUDO="sudo"

section "♻️ Updating package index..."
${SUDO:-} apt -y update
install_via_apt
