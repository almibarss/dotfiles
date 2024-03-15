main() {
  export SDKMAN_DIR=${HOMEBREW_PREFIX:-$(brew --prefix)}/opt/sdkman-cli/libexec
  copy_function sdkman_init_lazy sdk
  add_candidates_to_path
  set_java_home
}

sdkman_init_lazy() {
  source "${SDKMAN_DIR}/bin/sdkman-init.sh"  # loads sdk function
  copy_function sdk sdk_command
  copy_function sdk_proxy sdk
  sdk_proxy "$@"
}

# https://frederic-hemberger.de/articles/speed-up-initial-zsh-startup-with-lazy-loading/
sdk_proxy() {
	if (($# == 2)) && [[ $1 =~ ^(u|use)$ ]]; then
		local candidate=$2
		sdk_command use $candidate $(sdk_fuzzy_find_local_version $candidate)
	else
		sdk_command "$@"
	fi
}

set_java_home() {
  export JAVA_HOME=${SDKMAN_DIR}/candidates/java/current
}

# https://unix.stackexchange.com/a/204944
add_candidates_to_path() {
  for candidate in ${SDKMAN_DIR}/candidates/*(N); do
    if [[ -d "${candidate}/current/bin" ]]; then
      PATH="${candidate}/current/bin:${PATH}"
    fi
  done
}

# https://mharrison.org/post/bashfunctiooverride/
copy_function() {
	local ORIG_FUNC=$(declare -f $1)
	local NEWNAME_FUNC="$2${ORIG_FUNC#$1}"
	eval "$NEWNAME_FUNC"
}

sdk_fuzzy_find_local_version() {
	local candidate=$1
	__sdkman_build_version_csv $candidate | tr ',' '\n' | sort -r -n | gum filter --height=3
}

main
