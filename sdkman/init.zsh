SDKMAN_DIR="/usr/local/sdkman"

if [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then

# https://frederic-hemberger.de/articles/speed-up-initial-zsh-startup-with-lazy-loading/
sdk() {
	unfunction "$0"

	if (( ! ${+SDKMAN_VERSION} )); then
		source "$SDKMAN_DIR/bin/sdkman-init.sh"
	fi

	$0 "$@"
}

fi
