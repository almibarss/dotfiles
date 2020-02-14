# Vim

## XDG

Vim doesn't support the XDG Base Directory Specification out-of-the-box but there exist some workarounds.

### Config files

This setting applies to [.vimrc](https://github.com/mperezi/dotfiles/blob/master/vim/config):

```bash
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/config" | source $MYVIMRC'
```

### Cache files

```
set directory=$XDG_CACHE_HOME/vim/swaps//,~,/tmp
set viewdir=$XDG_CACHE_HOME/vim/view
set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
```

## Plugins

Plugins are managed by [vim-plug](https://github.com/junegunn/vim-plug). To edit the [plugins.vim](https://github.com/mperezi/dotfiles/blob/master/vim/plugins.vim) file with the list of plugins:

```bash
$ dot vim plugins
```

The installation process will start after _saving_ the file.

## Config

To edit the .vimrc file:

```bash
$ dot vim config
```

### Local config

An additional .vimrc file can be used to handle configuration that is specific to the local machine:

```bash
$ dot vim local-config
```

This file is located in ~/.dotfiles/local/vimrc (although [ignored](https://github.com/mperezi/dotfiles/blob/master/.gitignore) from version control).