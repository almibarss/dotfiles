export EDITOR=vim
export CLICOLOR=1
export LSCOLORS=exfxfeaeBxxehehbadacea
export LS_COLORS="di=34:ln=35:so=35;44:pi=30;44:ex=1;31:bd=0;44:cd=37;44:su=37;41:sg=30;43:tw=30;42:ow=34;40"

# XDG

export DOCKER_CONFIG=${XDG_CONFIG_HOME}/docker
export GRADLE_USER_HOME=${XDG_DATA_HOME}/gradle
export BAT_CONFIG_PATH=${XDG_CONFIG_HOME}/bat/config
export RIPGREP_CONFIG_PATH=${XDG_CONFIG_HOME}/ripgrep/config
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/config" | source $MYVIMRC'

# Plugins

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'
export ZSH_AUTOSUGGEST_USE_ASYNC=true

export ZSH_HIGHLIGHT_MAXLENGTH=300
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

export PROMPT_LEAN_ABBR_METHOD="shrink"
export PROMPT_LEAN_PATH_PERCENT=30

# Misc

export HOMEBREW_AUTO_UPDATE_SECS=86400
export HOMEBREW_NO_ANALYTICS=true

export TAG_SEARCH_PROG=rg
