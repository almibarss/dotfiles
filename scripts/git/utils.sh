git_info() {
	local rev_list ahead behind
	rev_list=$(git rev-list --left-right --count HEAD...@{u})
	ahead=$(awk '{print $1}' <<<$rev_list)
	behind=$(awk '{print $2}' <<<$rev_list)

	if (( ahead == 0 && behind == 0 )); then
		echo "synced"
	elif (( ahead == 0 && behind > 0)); then
		echo "behind"
	elif (( ahead > 0 && behind == 0)); then
		echo "ahead"
	else
		echo "diverged"
	fi
}
