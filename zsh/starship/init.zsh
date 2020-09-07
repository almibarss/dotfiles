if has starship; then

STARSHIP_INIT_ZSH="${XDG_DATA_HOME}/zsh/starship-init.zsh"
if [[ ! -s ${STARSHIP_INIT_ZSH} ]]; then
	starship init zsh --print-full-init >|${STARSHIP_INIT_ZSH}
fi
source ${STARSHIP_INIT_ZSH}

fi
