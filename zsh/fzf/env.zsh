export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS
    --color=fg:#e5e9f0,bg:#3b4251,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#3b4251,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b
	--bind '?:toggle-preview'
	--preview-window hidden
	--reverse
"

if has fd; then
	# https://github.com/junegunn/fzf#tips
	export FZF_CTRL_T_COMMAND="fd --type f"
fi

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
