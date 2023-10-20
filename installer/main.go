package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"

	rfs "github.com/sota0121/dotfiles/installer/sfs"
	rio "github.com/sota0121/dotfiles/installer/sio"
)

const (
	DotfilesDir     = "dotfiles"
	ZshrcFile       = ".zshrc"
	BrewCommand     = "brew"
	DotfilesRepoURL = "git@github.com:sota0121/dotfiles.git"
)

var (
	HomeDir                       = os.Getenv("HOME")
	CustomBrewInstallFuncName     = "my_brew_install"
	CustomBrewCaskInstallFuncName = "my_brew_cask_install"
	AliasPrefix                   = "alias "
	KeywordBI                     = "bi"
	KeywordBCI                    = "bci"
	AliasPrefixBI                 = AliasPrefix + KeywordBI + "="
	AliasPrefixBCI                = AliasPrefix + KeywordBCI + "="
)

// Application supports dependency injection.
type App struct {
	FS rfs.FileSystem
	IO rio.IOsystem
}

// NewApp returns a new App.
func NewApp(actualFS rfs.FileSystem, actualIO rio.IOsystem) *App {
	return &App{
		FS: actualFS,
		IO: actualIO,
	}
}

// cloneDotfilesRepo clones this repository to `$HOME/dotfiles`.
// If `$HOME/dotfiles` already exists, this function does nothing.
func (a *App) cloneDotfilesRepo() error {
	dotfilesPath := fmt.Sprintf("%s/%s", HomeDir, DotfilesDir)

	// Check if directory already exists
	_, err := a.FS.Stat(dotfilesPath)
	if os.IsExist(err) {
		return fmt.Errorf("'%s' directory already exists", dotfilesPath)
	}
	if err != nil {
		return fmt.Errorf("failed to check if '%s' directory already exists: %w", dotfilesPath, err)
	}

	// Clone this repository to `$HOME/dotfiles`
	cmd := exec.Command("git", "clone", DotfilesRepoURL, dotfilesPath)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err = cmd.Run()
	if err != nil {
		return fmt.Errorf("failed to clone this repository to '%s': due to %w", dotfilesPath, err)
	}
	return nil
}

// installAlias installs `bi` and `bci` commands to `$HOME/.zshrc` as alias.
// If `$HOME/.zshrc` does not exist, this function creates it.
// If the aliases already exist, this function does nothing.
func (a *App) installAlias() error {
	zshrcPath := fmt.Sprintf("%s/%s", HomeDir, ZshrcFile)

	// Create file if not exists
	f, err := a.FS.OpenFile(zshrcPath, os.O_RDWR|os.O_CREATE|os.O_APPEND, 0666)
	if err != nil {
		return fmt.Errorf("failed to open '%s': due to %w", zshrcPath, err)
	}
	defer f.Close()

	// Read contents
	content, err := a.IO.ReadAll(f)
	if err != nil {
		return fmt.Errorf("failed to read '%s': due to %w", zshrcPath, err)
	}

	// Check if functions already exist
	if strings.Contains(string(content), CustomBrewInstallFuncName) || strings.Contains(string(content), CustomBrewCaskInstallFuncName) {
		return fmt.Errorf("`%s` or `%s` function already exists in %s. Exiting", CustomBrewInstallFuncName, CustomBrewCaskInstallFuncName, ZshrcFile)
	}

	// Check if aliases already exist
	if strings.Contains(string(content), AliasPrefixBI) || strings.Contains(string(content), AliasPrefixBCI) {
		return fmt.Errorf("`bi` or `bci` alias already exists in %s. Exiting", ZshrcFile)
	}

	// Write functions to `$HOME/.zshrc`
	bundleFilePath := fmt.Sprintf("%s/%s/%s", HomeDir, DotfilesDir, ".Brewfile")

	_, err = f.WriteString(fmt.Sprintf(`function %s() {
		brew install "$@"
		brew bundle dump --force --file=%s
	}`, CustomBrewInstallFuncName, bundleFilePath))
	if err != nil {
		return fmt.Errorf("failed to write function to '%s': due to %w", zshrcPath, err)
	}
	_, err = f.WriteString(fmt.Sprintf(`function %s() {
		brew cask install "$@"
		brew bundle dump --force --file=%s
	}`, CustomBrewCaskInstallFuncName, bundleFilePath))
	if err != nil {
		return fmt.Errorf("failed to write function to '%s': due to %w", zshrcPath, err)
	}

	// Write alias to `$HOME/.zshrc`
	_, err = f.WriteString("\n# My Dotfiles installer aliases\n")
	if err != nil {
		return fmt.Errorf("failed to write alias to '%s': due to %w", zshrcPath, err)
	}
	_, err = f.WriteString(fmt.Sprintf("%s \"%s\"\n", AliasPrefixBI, CustomBrewInstallFuncName))
	if err != nil {
		return fmt.Errorf("failed to write alias to '%s': due to %w", zshrcPath, err)
	}
	_, err = f.WriteString(fmt.Sprintf("%s \"%s\"\n", AliasPrefixBCI, CustomBrewCaskInstallFuncName))
	if err != nil {
		return fmt.Errorf("failed to write alias to '%s': due to %w", zshrcPath, err)
	}

	return nil
}

// brewBundle installs packages using `$HOME/dotfiles/.Brewfile`.
func (a *App) brewBundle() error {
	bundleFilePath := fmt.Sprintf("%s/%s/%s", HomeDir, DotfilesDir, ".Brewfile")

	cmd := exec.Command(BrewCommand, "bundle", "--file", bundleFilePath)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	if err != nil {
		return fmt.Errorf("failed to install packages using '%s': due to %w", bundleFilePath, err)
	}
	return nil
}

// reloadZshrc reloads `$HOME/.zshrc` to apply the alias.
func (a *App) reloadZshrc() error {
	zshrcPath := fmt.Sprintf("%s/%s", HomeDir, ZshrcFile)

	cmd := exec.Command("source", zshrcPath)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	if err != nil {
		return fmt.Errorf("failed to reload '%s': due to %w", zshrcPath, err)
	}
	return nil
}

func main() {
	log.Println("Start install dotfiles")

	// 0. Initialize application
	app := NewApp(rfs.RealFileSystem{}, rio.RealIOsystem{})

	// 1. Clone this repository to `$HOME/dotfiles`.
	if err := app.cloneDotfilesRepo(); err != nil {
		fmt.Println(err)
		return
	}

	// 2. Install `bi` and `bci` commands to `$HOME/.zshrc` as alias.
	if err := app.installAlias(); err != nil {
		fmt.Println(err)
		return
	}

	// 3. Brew bundle install using `$HOME/dotfiles/.Brewfile`.
	if err := app.brewBundle(); err != nil {
		fmt.Println(err)
		return
	}

	// 4. Reload `$HOME/.zshrc` to apply the alias.
	app.reloadZshrc()

	log.Println("Finish install dotfiles")
}
