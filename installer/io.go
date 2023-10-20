//go:generate mockgen -source=$GOFILE -destination=mock/io_mock.go -package=mock
package main

import "io"

// FileSystem, IOsystem をモックしてテストできるようにするためのインターフェース

type IOsystem interface {
	ReadAll(r io.Reader) ([]byte, error)
}

// RealIOsystem is a just wrapper of io package.
type RealIOsystem struct{}

func (RealIOsystem) ReadAll(r io.Reader) ([]byte, error) {
	return io.ReadAll(r)
}
