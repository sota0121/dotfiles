.PHONY: build run test generate mod-tidy go-get

BIN_DIR = bin
INSTALLER_NAME = installer
INSTALLER_PATH = ./main.go
TARGET_PRIVATE_MODULES = github.com/sota0121

build: mod-tidy go-get generate test
	@echo "Building installer..."
	@go build -o $(BIN_DIR)/$(INSTALLER_NAME) $(INSTALLER_PATH)
	@echo "Installer built successfully!"

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
