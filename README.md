# mperezi/dotfiles

## Installation

```bash
$ bash <(curl -sL https://raw.githubusercontent.com/mperezi/dotfiles/master/install.sh)
```

The installation script will clone the dotfiles repo by default into ~/.dotfiles. You can optionally choose a custom directory by specifying the environment variable `$DOTFILES_HOME`. The dotfiles repo will then get symlinked into ~/.dotfiles as well.

## Update

```bash
$ dot update
```

## Features

### 🚴‍♂ Performance

Opening a new terminal should be _really_ fast, despite all the fancy features you may use. [Zim](https://github.com/zimfw/zimfw) can help a lot with [speed](https://github.com/zimfw/zimfw/wiki/Speed) along with techniques such as the [lazy loading](https://github.com/mperezi/dotfiles/blob/master/sdkman/init.zsh#L5-L14) pattern.

### 🧠 Productivity

Saving fractions of milliseconds here and there eventually adds up:

* [fzf](https://github.com/junegunn/fzf) is _the tool_ that changes the game: shell history, file trees, brew packages, whatever.
* Syntax highlighting [(1)](https://github.com/zsh-users/zsh-syntax-highlighting) [(2)](https://github.com/sharkdp/bat): because parsing blank lines of text all the time can be frustrating.
* [Minimalistic prompt](https://github.com/mperezi/lean): staying out of the way most of the time while still providing useful information. 
* Clever tooling: 
  * [ripgrep](https://github.com/BurntSushi/ripgrep) + [tag](https://github.com/aykamko/tag) for seamless browsing of search results.
  * [autojump](https://github.com/wting/autojump): where was that directory? uh, don't mind.

### 🧹 XDG Base Directory Specification

Keep your [home directory as clean](https://maex.me/2019/12/the-power-of-the-xdg-base-directory-specification/) as if it were your bedroom 🙄

Take a look at the list of [software that currently supports XDG](https://wiki.archlinux.org/index.php/XDG_Base_Directory).

### 🎣 Extensibility

[Each machine will eventually need its own settings](https://www.anishathalye.com/2014/08/03/managing-your-dotfiles/#local-customization) that can be hooked into the main dotfiles without messing with them. 

## More dotfiles

* [denisidoro/dotfiles](https://github.com/denisidoro/dotfiles): ❤️ the dot command
* [rgomezcasas/dotfiles](https://github.com/rgomezcasas/dotfiles): 🐢💨 fine-tuning
* [anishathalye/dotbot](https://github.com/anishathalye/dotbot): easily manage your dotfiles