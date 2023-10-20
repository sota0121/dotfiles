//go:generate mockgen -source=$GOFILE -destination=mock/fs_mock.go -package=mock
package main

import (
	"os"
)

// FileSystem, IOsystem をモックしてテストできるようにするためのインターフェース

type FileSystem interface {
	Stat(name string) (os.FileInfo, error)
	OpenFile(name string, flag int, perm os.FileMode) (*os.File, error)
}

// RealFileSystem is a just wrapper of os package.
type RealFileSystem struct{}

func (RealFileSystem) Stat(name string) (os.FileInfo, error) {
	return os.Stat(name)
}

func (RealFileSystem) OpenFile(name string, flag int, perm os.FileMode) (*os.File, error) {
	return os.OpenFile(name, flag, perm)
}
