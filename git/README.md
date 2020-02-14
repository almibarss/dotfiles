# Git

## XDG

Git supports the XDG Base Directory Specification since version [1.7.12](https://github.com/git/git/commit/0d94427).

## Config

To edit the global [.gitconfig](https://github.com/mperezi/dotfiles/blob/master/git/config) file:

```bash
$ dot git config
```

### Local config

An additional .gitconfig file can be used to handle configuration that is specific to the local machine such as the `user.name` and `user.email`:

```bash
$ dot git local-config
```

This file is located in ~/.dotfiles/local/gitconfig (although [ignored](https://github.com/mperezi/dotfiles/blob/master/.gitignore) from version control).

## Ignore

To edit the global [.gitignore](https://github.com/mperezi/dotfiles/blob/master/git/ignore) file:

```bash
$ dot git ignore
```