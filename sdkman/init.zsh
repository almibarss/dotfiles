SDKMAN_DIR="/usr/local/sdkman"

if [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then

init_sdkman() {
	if (( ! ${+SDKMAN_VERSION} )); then
		source "$SDKMAN_DIR/bin/sdkman-init.sh"
	fi
}

# https://frederic-hemberger.de/articles/speed-up-initial-zsh-startup-with-lazy-loading/
sdk() {
	unfunction "$0"
	init_sdkman
	$0 "$@"
}

mvn() {
	unfunction "$0"
	init_sdkman
	$0 "$@"
}

fi
