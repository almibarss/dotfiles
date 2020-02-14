source ~/.dotfiles/scripts/core/utils.sh

# http://linuxcommand.org/lc3_adv_tput.php
BOLD=""
DIM=""
RED=""
GREEN=""
YELLOW=""
BLUE=""
RESET=""

is_tty() {
	case $1 in
		stdin)  [ -t 0 ];;
		stdout) [ -t 1 ];;
		stderr) [ -t 2 ];;
		*)      [ -t $1 ];;
	esac
}

should_use_colors() {
	local -r file_desc=$1
	[[ -z ${DOTFILES_NO_COLOR:-} ]] &&
		is_tty $file_desc &&
		has tput &&
		tput init 2>/dev/null
}

set_colors() {
	local -r file_desc=$1
	if should_use_colors $file_desc; then
		RED=$(tput setaf 1)
		GREEN=$(tput setaf 2)
		YELLOW=$(tput setaf 3)
		BLUE=$(tput setaf 4)
		BOLD=$(tput bold)
		DIM=$(tput setaf 7)
		RESET=$(tput sgr0)
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		DIM=""
		RESET=""
	fi

	export RED GREEN YELLOW BLUE BOLD DIM RESET
}
