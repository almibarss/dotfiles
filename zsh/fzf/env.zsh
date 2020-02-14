export FZF_DEFAULT_OPTS="
	--color=pointer:#ebdbb2,bg+:#3c3836,fg:#ebdbb2,fg+:#fbf1c7,hl:#8ec07c,info:#928374,header:#fb4934
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
	--preview 'echo {}'
	--preview-window down:3:hidden:wrap
"
