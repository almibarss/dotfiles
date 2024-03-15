main() {
	copy_function j_init_lazy j
}

j_init_lazy() {
	if [ -z "${AUTOJUMP_SOURCED}" ]; then
		. "${HOMEBREW_PREFIX:-$(brew --prefix)}/share/autojump/autojump.zsh"
	fi
	j "$@"
}

# https://mharrison.org/post/bashfunctiooverride/
copy_function() {
	local ORIG_FUNC=$(declare -f $1)
	local NEWNAME_FUNC="$2${ORIG_FUNC#$1}"
	eval "$NEWNAME_FUNC"
}

main
