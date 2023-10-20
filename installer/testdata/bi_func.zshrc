# My Dotfiles installer functions

function my_brew_install() {
	brew install "$@"
	brew bundle dump --force --file=./testdata/./testdata/dotfiles/.Brewfile
}
# My Dotfiles installer aliases
alias bi= "my_brew_install"
