SSH_CONFIG=~/.ssh # unfortunately, no XDG for ssh -> https://superuser.com/a/1606519
LOCAL_SSH=~/.dotfiles/local/ssh

[[ ! -d $LOCAL_SSH ]] && return                                            # no local ssh
[[ -L $SSH_CONFIG && $(readlink -f $SSH_CONFIG) == $LOCAL_SSH ]] && return # already linked

if [[ -d $SSH_CONFIG ]]; then
	echo "Backing up existing ssh config"
	mv -i $SSH_CONFIG ${SSH_CONFIG}.bak
fi

echo "Linking local ssh"
ln -i -s $LOCAL_SSH $SSH_CONFIG
