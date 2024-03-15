alias rg=tag
alias rgni='rg --no-ignore'

export RIPGREP_CONFIG_PATH=${XDG_CONFIG_HOME}/ripgrep/config
export TAG_SEARCH_PROG=rg
export TAG_CMD_FMT_STRING="${EDITOR} -c \"call cursor({{.LineNumber}}, {{.ColumnNumber}})\" {{.Filename}}"

tag() {
	command tag "$@"
	source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null
}
