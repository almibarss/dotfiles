# https://stackoverflow.com/a/26759734
has() {
	[[ -x $(command -v $1) ]]
}

os_type() {
	case $(uname -s) in
		Linux)  linux_flavor;;
		Darwin) echo "macos";;
		*)      echo "unknown";;
	esac
}

linux_flavor() {
	local flavor
	if [[ -r /etc/os-release ]]; then
		flavor=$(awk -F= '/^ID=/{print tolower($2)}' </etc/os-release)
	fi
	echo ${flavor:-unknown}
}

os_name() {
	case $(uname -s) in
		Linux)  linux_info;;
		Darwin) macos_info;;
		*)      echo "unknown";;
	esac
}

linux_info() {
	local info
	if [[ -r /etc/os-release ]]; then
		info="🐧  $(awk -F= '/^PRETTY_NAME=/{gsub(/"/, "", $2);print $2}' </etc/os-release)"
	fi
	echo ${info:-🐧  Linux}
}

macos_info() {
	local info
	if has sw_vers; then
		info=" $(sw_vers -productName) $(sw_vers -productVersion)"
	fi
	echo ${info:- Mac OS}
}

exec_remote() {
	local url=$1 shell=$2

	if [[ $shell == *"-with-sudo" ]]; then 
		[[ $(whoami) != "root" ]] && sudo="sudo -E"
		shell=${shell#-with-sudo}
	fi
	
	case $shell in
		*ruby) flags='-e';;
	esac

	script=$(curl -fsSL $url)
	exit_status=$?
	if [[ $exit_status == 0 ]]; then
		$sudo ${shell:-bash} ${flags:--c} "$script"
		exit_status=$?
	fi

	unset -v sudo flags script

	return $exit_status
}
