package main

import (
	"os"
	"testing"

	"github.com/golang/mock/gomock"
	mock_rfs "github.com/sota0121/dotfiles/installer/sfs"
	rfs "github.com/sota0121/dotfiles/installer/sfs"
	mock_rio "github.com/sota0121/dotfiles/installer/sio"
	rio "github.com/sota0121/dotfiles/installer/sio"

	"github.com/stretchr/testify/assert"
)

var (
	testHomeDir       = "./testdata"
	testDotfilesDir   = testHomeDir + "/" + DotfilesDir
	noExistZshrcFile  = "no_exist.zshrc"
	emtpyZshrcFile    = "empty.zshrc"
	biOnlyZshrcFile   = "bi.zshrc"
	biFuncZshrcFile   = "bi_func.zshrc"
	bciOnlyZshrcFile  = "bci.zshrc"
	bciFuncZshrcFile  = "bci_func.zshrc"
	biAndBciZshrcFile = "bi_bci.zshrc"
)

func TestCloneDotfilesRepo(t *testing.T) {
	// Scenario: dotfiles directory already exists
	t.Run("dotfiles directory already exists", func(t *testing.T) {
		ctrl := gomock.NewController(t)
		defer ctrl.Finish()

		mockFS := mock_rfs.NewMockFileSystem(ctrl)

		mockFS.EXPECT().Stat(gomock.Any()).Return(nil, os.ErrExist)

		mockApp := NewApp(testHomeDir, testDotfilesDir, biAndBciZshrcFile, mockFS, nil)

		err := mockApp.cloneDotfilesRepo()
		assert.Error(t, err)
		assert.Contains(t, err.Error(), "directory already exists")
	})

}

func TestInstallAliases(t *testing.T) {
	// Delete files after test
	t.Cleanup(func() {
		err := os.Remove(testHomeDir + "/" + noExistZshrcFile)
		if err != nil {
			t.Fatalf("Failed to clean up test file: %s with error: %s", noExistZshrcFile, err.Error())
		}
	})

	// Scenario: zshrc file does not exist
	t.Run("zshrc file does not exist", func(t *testing.T) {
		ctrl := gomock.NewController(t)
		defer ctrl.Finish()

		// 実際にファイルを作る
		mockFS := rfs.RealFileSystem{}
		mockIO := mock_rio.NewMockIOsystem(ctrl)

		zshrcfilepath := testHomeDir + "/" + noExistZshrcFile

		// 仮に空のファイルがあるとする（クリーンインストールを想定）
		zshrcContent, _ := os.ReadFile(zshrcfilepath)
		mockIO.EXPECT().ReadAll(gomock.Any()).Return(zshrcContent, nil)

		mockApp := NewApp(testHomeDir, testDotfilesDir, noExistZshrcFile, mockFS, mockIO)

		// want: create new zshrc file and write aliases
		err := mockApp.installAlias()
		assert.NoError(t, err)
	})

	// Scenario: exit due to zshrc has my_brew_install function
	t.Run("zshrc file exists and my_brew_install function exists", func(t *testing.T) {
		// 実際のファイルを取り扱う
		mockFS := rfs.RealFileSystem{}
		mockIO := rio.RealIOsystem{}

		mockApp := NewApp(testHomeDir, testDotfilesDir, biFuncZshrcFile, mockFS, mockIO)

		// want: do nothing because my_brew_install function already exists
		err := mockApp.installAlias()
		assert.Error(t, err)
		assert.Contains(t, err.Error(), "function is already defined")
	})

	// Scenario: exit due to zshrc has bi alias
	t.Run("zshrc file exists and bi alias exists", func(t *testing.T) {
		// 実際のファイルを取り扱う
		mockFS := rfs.RealFileSystem{}
		mockIO := rio.RealIOsystem{}

		mockApp := NewApp(testHomeDir, testDotfilesDir, biOnlyZshrcFile, mockFS, mockIO)

		// want: do nothing because bi alias already exists
		err := mockApp.installAlias()
		assert.Error(t, err)
		assert.Contains(t, err.Error(), "alias already exists")
	})
}
