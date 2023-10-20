#! /bin/zsh

# Prepare to set environment variables
## If the environment variables are already set, confirm to overwrite them
if [ -n "$MY_DOTFILES_DIR" ]; then
  echo "Overwrite environment variables (MY_DOTFILES_DIR) ? [y/n]"
  read answer
  if [ $answer = "y" ]; then
    unset MY_DOTFILES_DIR
  else
    echo "Exit"
    exit 1
  fi
fi


# Set environment variables
MY_DOTFILES_DIR=~/dotfiles

# Prepare to clone the repository
## If ~/dotfiles dir already exists, confirm to remove it
if [ -d ~/dotfiles ]; then
  echo "Remove ~/dotfiles dir? [y/n]"
  read answer
  if [ $answer = "y" ]; then
    rm -rf ~/dotfiles
  else
    echo "Exit"
    exit 1
  fi
fi

# Clone the repository
git clone git@github.com:sota0121/dotfiles.git ~/dotfiles

# Prepare to install `bi` and `bci` commands
## If `bi` and `bci` aliases already exist, confirm to overwrite them
if [ -n "$(alias | grep bi)" ]; then
  echo "Overwrite aliases (bi, bci) ? [y/n]"
  read answer
  if [ $answer = "y" ]; then
    unalias bi
    unalias bci
  else
    echo "Exit"
    exit 1
  fi
fi


# Install `bi` and `bci` commands
echo 'function bi() {
    brew install "$@"
    brew bundle dump --force --file=
}

# dotfilesのクローン
git clone [your-dotfiles-repo-url] ~/dotfiles

# .zshrcにmy_brew_install関数を追加
echo 'function my_brew_install() {
    brew install "$@"
    brew bundle dump --force --file=~/dotfiles/.Brewfile
}' >> ~/.zshrc
echo 'alias bi="my_brew_install"' >> ~/.zshrc