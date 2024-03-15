export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
	--bind '?:toggle-preview'
	--preview-window hidden
	--reverse
"

# https://github.com/junegunn/fzf#tips
export FZF_CTRL_T_COMMAND="fd --type f"

export FZF_CTRL_T_OPTS="
	--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'
	--preview-window right:70%:hidden:wrap
"

export FZF_CTRL_R_OPTS="
	--no-info
	--preview 'echo {}'
	--preview-window down:3:hidden:wrap
	--header='ctrl-y to copy to clipboard, ctrl-e to query explainshell.com'
	--bind \"ctrl-y:execute(echo {} | pbcopy)\"
	--bind \"ctrl-e:execute(curl -sLG -o /dev/null -w '%{url_effective}' --data-urlencode cmd={} https://explainshell.com/explain | xargs open)\"
"

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
