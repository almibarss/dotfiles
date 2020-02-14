if has autojump; then

export AUTOJUMP_SOURCED=1

autojump_chpwd() {
    autojump --add "$PWD" >/dev/null &!
}

typeset -gaU chpwd_functions
chpwd_functions+=autojump_chpwd

fi
