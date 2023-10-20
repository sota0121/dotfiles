package main

import (
	"os"
	"testing"

	"github.com/golang/mock/gomock"
	mock_rfs "github.com/sota0121/dotfiles/installer/sfs"

	"github.com/stretchr/testify/assert"
)

func TestCloneDotfilesRepo(t *testing.T) {
	ctrl := gomock.NewController(t)
	defer ctrl.Finish()

	mockFS := mock_rfs.NewMockFileSystem(ctrl)

	// Scenario: dotfiles directory already exists
	mockFS.EXPECT().Stat(gomock.Any()).Return(nil, os.ErrExist)

	mockApp := NewApp(mockFS, nil)

	err := mockApp.cloneDotfilesRepo()
	assert.Error(t, err)
}
