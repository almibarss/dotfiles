if has fzf; then

__fsel() {
	local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
		-o -type f -print \
		-o -type d -print \
		-o -type l -print 2> /dev/null | cut -b3-"}"
	setopt localoptions pipefail no_aliases 2> /dev/null
	eval "$cmd" |
		FZF_DEFAULT_OPTS="--height 40% --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf --multi "$@" | 
		while read item; do
		echo -n "${(q)item} "
	done
	local ret=$?
	echo
	return $ret
}

fzf-file-widget() {
	LBUFFER="${LBUFFER}$(__fsel)"
	local ret=$?
	zle reset-prompt
	return $ret
}

zle     -N   fzf-file-widget
bindkey '^T' fzf-file-widget

fzf-history-widget() {
	local selected num
	setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2>/dev/null
	selected=( $(fc -rln 1 |
		FZF_DEFAULT_OPTS="--height 40% $FZF_DEFAULT_OPTS --tiebreak=index
			--bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} --no-multi" fzf) )
	local ret=$?
	if [[ -n $selected ]]; then
		LBUFFER="$selected"
	fi
	zle reset-prompt
	return $ret
}

zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

fi
