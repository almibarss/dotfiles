# ZSH

## XDG

Zsh doesn't support the XDG Base Directory Specification out-of-the-box but there exist some workarounds.

[.zshenv](https://github.com/mperezi/dotfiles/blob/master/zsh/zshenv) must be kept in the home directory though because of the shell bootstrap process.

### Config files (.zshenv)

This setting applies to [.zshrc](https://github.com/mperezi/dotfiles/blob/master/zsh/config) and [.zimrc](https://github.com/mperezi/dotfiles/blob/master/zsh/zim/config):

```bash
ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
```

### History file (.zshrc)

```bash
HISTFILE=${XDG_DATA_HOME}/zsh/history
```

### Cache files (.zshrc)

```bash
zstyle ':zim:completion' dumpfile ${XDG_CACHE_HOME}/zsh/zcompdump
```

## Plugins

Plugins are managed by [ZIM](https://github.com/zimfw/zimfw). To edit the [.zimrc](https://github.com/mperezi/dotfiles/blob/master/zsh/zim/config) file with the list of plugins:

```bash
$ dot zsh plugins
```

The installation process will start after _saving_ the file.

## Config

To edit the .zshrc file:

```bash
$ dot zsh config
```

Changes will be applied after restarting the terminal.

### Local config

An additional .zshrc file can be used to handle configuration that is specific to the local machine:

```bash
$ dot zsh local-config
```

This file is located in ~/.dotfiles/local/zshrc (although [ignored](https://github.com/mperezi/dotfiles/blob/master/.gitignore) from version control).