// Code generated by MockGen. DO NOT EDIT.
// Source: io.go

// Package mock is a generated GoMock package.
package mock

import (
	io "io"
	reflect "reflect"

	gomock "github.com/golang/mock/gomock"
)

// MockIOsystem is a mock of IOsystem interface.
type MockIOsystem struct {
	ctrl     *gomock.Controller
	recorder *MockIOsystemMockRecorder
}

// MockIOsystemMockRecorder is the mock recorder for MockIOsystem.
type MockIOsystemMockRecorder struct {
	mock *MockIOsystem
}

// NewMockIOsystem creates a new mock instance.
func NewMockIOsystem(ctrl *gomock.Controller) *MockIOsystem {
	mock := &MockIOsystem{ctrl: ctrl}
	mock.recorder = &MockIOsystemMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockIOsystem) EXPECT() *MockIOsystemMockRecorder {
	return m.recorder
}

// ReadAll mocks base method.
func (m *MockIOsystem) ReadAll(r io.Reader) ([]byte, error) {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "ReadAll", r)
	ret0, _ := ret[0].([]byte)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

// ReadAll indicates an expected call of ReadAll.
func (mr *MockIOsystemMockRecorder) ReadAll(r interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "ReadAll", reflect.TypeOf((*MockIOsystem)(nil).ReadAll), r)
}
