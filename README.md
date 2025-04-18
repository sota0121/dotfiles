# dotfiles

## Why I use this repository

- I want to manage my dotfiles in a single repository.
- I want to install my dotfiles with a single command.
- I want to install my dotfiles without git command.
- I want to update and sync my dotfiles with a single command.

## Summary

1. This repository is a collection of my dotfiles.
2. This repository provides a script to install or backup my dotfiles.

## Prerequisites

- [Git](https://git-scm.com)
- [Homebrew](https://brew.sh)
- [Just](https://just.systems/man/en/introduction.html)
  - `brew install just`

## Targets

- .config/nvim : manual symlink
- ~/.zshrc : see `just zsh`
- ~/.Brewfile : see `just brew`

## Task runner

- Please run `just` command to see how to use this repository.

---

# Old README

## Features

- [x] Provide `install.sh` to install dotfiles with a single command.
- [x] Provide a custom brew install command `bi`.
  - `bi` is a set of `brew install` and `brew bundle dump`.
  - This command installs a formula and syncs `dotfiles/.Brewfile`.
- [x] Provide a custom brew cask install command `bci`.
  - `bci` is a set of `brew cask install` and `brew bundle dump`.
  - This command installs a cask and syncs `dotfiles/.Brewfile`.


## Usage

### Install

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/sota0121/dotfiles/main/install.sh)"
```

### Brew install and Sync .Brewfile

```bash
# custom brew install
bi $formula

# custom brew cask install
bci $cask
```

### Git Push your latest dotfiles

```bash
cd $DOTFILES_DIR
git add .
git commit -m "update dotfiles"
git push origin main
```

### Install brew pkgs with latest .Brewfile

```bash
cd $DOTFILES_DIR
brew bundle install --file .Brewfile
```


## What `install.sh` does

1. Clone this repository to `$HOME/dotfiles`.
   1. If the directory already exists, `install.sh` will exit.
2. Install `bi` and `bci` commands to `$HOME/.zshrc` as alias.
   1. If the alias already exists, `install.sh` will exit.
3. Brew bundle install using `$HOME/dotfiles/.Brewfile`.
4. Reload `$HOME/.zshrc` to apply the alias.

