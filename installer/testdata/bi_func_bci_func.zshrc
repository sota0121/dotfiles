# My Dotfiles installer functions

function my_brew_install() {
	brew install "$@"
	brew bundle dump --force --file=./testdata/./testdata/dotfiles/.Brewfile
}
function my_brew_cask_install() {
	brew cask install "$@"
	brew bundle dump --force --file=./testdata/./testdata/dotfiles/.Brewfile
}
# My Dotfiles installer aliases
alias bi= "my_brew_install"
alias bci= "my_brew_cask_install"
