//go:generate mockgen -source=$GOFILE -destination=./io_mock.go -package=$GOPACKAGE
package sio

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
