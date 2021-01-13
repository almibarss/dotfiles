export SDKMAN_DIR="/usr/local/sdkman"

# https://mharrison.org/post/bashfunctionoverride/
copy_function() {
	local ORIG_FUNC=$(declare -f $1)
	local NEWNAME_FUNC="$2${ORIG_FUNC#$1}"
	eval "$NEWNAME_FUNC"
}

if [[ -d ${SDKMAN_DIR} ]]; then

# https://unix.stackexchange.com/a/204944
for candidate in ${SDKMAN_DIR}/candidates/*(N); do
	if [[ -d "${candidate}/current/bin" ]]; then
		PATH="${candidate}/current/bin:${PATH}"
	fi
done

init_sdkman() {
	if (( ! ${+SDKMAN_VERSION} )); then
		source "${SDKMAN_DIR}/bin/sdkman-init.sh"
		copy_function sdk sdk_command
		copy_function sdk_proxy sdk
	fi
}

sdk_fuzzy_find_local_version() {
	local candidate=$1
	__sdkman_build_version_csv $candidate | tr ',' '\n' | sort -r -n | fzf -d '\.' --nth 1
}

# https://frederic-hemberger.de/articles/speed-up-initial-zsh-startup-with-lazy-loading/
sdk_proxy() {
	init_sdkman
	if (( $# == 2 )) && [[ $1 =~ ^(u|use)$ ]]; then
		local candidate=$2
		sdk_command use $candidate $(sdk_fuzzy_find_local_version $candidate)
	else
		sdk_command "$@"
	fi
}
copy_function sdk_proxy sdk

sdkman_auto_env() {
	if [[ -f .sdkmanrc ]]; then
		sdk env
	elif [[ -n $SDKMAN_ENV ]] && [[ ! $PWD =~ ^$SDKMAN_ENV ]]; then
		sdk env clear
	fi
}
add-zsh-hook chpwd sdkman_auto_env

sdkman_auto_env

fi
