.PHONY: build test generate

BIN_DIR = bin
INSTALLER_NAME = installer
INSTALLER_PATH = ./main.go

build:
	@echo "Building installer..."
	@go build -o $(BIN_DIR)/$(INSTALLER_NAME) $(INSTALLER_PATH)
	@echo "Installer built successfully!"

test:
	@echo "Running tests..."
	@go test ./...

generate:
	@echo "Generating mocks..."
	@go generate ./...
	@echo "Mocks generated successfully!"