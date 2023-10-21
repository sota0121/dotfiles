.PHONY: build xbuild run test generate mod-tidy go-get go-install

BIN_DIR = bin
INSTALLER_NAME = installer
INSTALLER_PATH = ./main.go
TARGET_PRIVATE_MODULES = github.com/sota0121

MOCKGEN_VERSION = v1.6.0

build: mod-tidy go-get generate test
	@echo "Building installer..."
	@go build -o $(BIN_DIR)/$(INSTALLER_NAME) $(INSTALLER_PATH)
	@echo "Installer built successfully!"

# Cross build for building release artifacts on CI
xbuild: mod-tidy go-get go-install generate test
	@echo "Building installer for linux..."
	@GOOS=linux GOARCH=amd64 go build -o $(BIN_DIR)/$(INSTALLER_NAME)_linux_amd64 $(INSTALLER_PATH)
	@echo "Installer for linux built successfully!"
	@echo "Building installer for darwin..."
	@GOOS=darwin GOARCH=amd64 go build -o $(BIN_DIR)/$(INSTALLER_NAME)_darwin_amd64 $(INSTALLER_PATH)
	@GOOS=darwin GOARCH=arm64 go build -o $(BIN_DIR)/$(INSTALLER_NAME)_darwin_arm64 $(INSTALLER_PATH)
	@echo "Installer for darwin built successfully!"

run:
	@echo "Running installer..."
	@go run $(INSTALLER_PATH)
	@echo "Installer ran successfully!"

test:
	@echo "Running tests..."
	@go test ./...

generate:
	@echo "Generating mocks..."
	@go generate ./...
	@echo "Mocks generated successfully!"

mod-tidy:
	@echo "Tidying up private go modules..."
	GOPRIVATE=$(TARGET_PRIVATE_MODULES) go mod tidy
	@echo "Go modules tidied up successfully!"

go-get:
	@echo "Getting private go modules..."
	GOPRIVATE=$(TARGET_PRIVATE_MODULES) go get -u
	@echo "Go modules got successfully!"

go-install:
	@echo "Installing mockgen..."
	@go install github.com/golang/mock/mockgen@$(MOCKGEN_VERSION)
	@echo "Mockgen installed successfully!"
