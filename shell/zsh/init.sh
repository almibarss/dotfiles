unsetopt localoptions

main() {
	set_prompt
	set_hist_options
}

set_prompt() {
	load_git_plugin
	# https://sureshjoshi.com/development/zsh-prompts-that-dont-suck
	export PROMPT='%(?.%F{14}⏺.%F{9}⏺)%f %2~ > '
	export RPROMPT='%F{8}${vcs_info_msg_0_:+ ${vcs_info_msg_0_}}'
}

set_hist_options() {
	# HIST_VERIFY: Whenever the user enters a line with history expansion, don’t execute the line directly; instead, perform history expansion and reload the line into the editing buffer.
	setopt NO_HIST_VERIFY
	# HIST_IGNORE_DUPS: Do not enter command lines into the history list if they are duplicates of the previous event.
	setopt HIST_IGNORE_DUPS
}

load_git_plugin() {
	autoload -Uz add-zsh-hook vcs_info
	setopt prompt_subst
	add-zsh-hook precmd vcs_info
	zstyle ':vcs_info:*' enable git
	zstyle ':vcs_info:git*' actionformats '%F{14}⏱ %*%f'
	zstyle ':vcs_info:git*' formats '%b%u%c'
}

# https://github.com/zsh-users/zsh/blob/ac0dcc9a63dc2a0edc62f8f1381b15b0b5ce5da3/NEWS#L37-L42
zle_highlight+=(paste:none)

[[ -e ${XDG_CONFIG_HOME}/zsh/zprof ]] && zmodload zsh/zprof

main
