BIN := bin/git-go-assist

.PHONY: tidy test vet lint build ci

tidy:
	go mod tidy
	gofmt -w cmd/git-go-assist/main.go

test:
	go test ./...

vet:
	go vet ./...

lint:
	golangci-lint run

build:
	mkdir -p bin
	go build -o $(BIN) ./cmd/git-go-assist

ci: tidy vet lint test build
	@echo "CI checks completed"
