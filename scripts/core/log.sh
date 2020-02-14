source ~/.dotfiles/scripts/core/utils.sh
source ~/.dotfiles/scripts/core/colors.sh

section() {
	local -r text=$1
	set_colors stdout
	sed \
		-e "s,_\(OK\)_,${GREEN}\1${RESET}," \
		-e "s,_\(FAILED\)_,${RED}\1${RESET}," \
		-e "s,_\(MISSING\)_,${RED}\1${RESET}," \
		-e "s,_\(SKIPPED\)_,${YELLOW}\1${RESET}," \
		-e "s,\(#.*$\),${DIM}\1${RESET}," \
		-e "s,^,${BOLD}," \
		-e "s,$,${RESET}," \
		<<<$text
}

_colorize() {
	local color=$1
	sed \
		-e "s,^,${color}," \
		-e "s,$,${RESET},"
}

success() {
	local -r text=$1
	set_colors stdout
	echo $text | _colorize "$GREEN"
}

warning() {
	local -r text=$1
	set_colors stdout
	echo $text | _colorize "$YELLOW"
}

error() {
	local -r text=$1
	set_colors stderr
	echo $text | _colorize "$RED" >&2
}
