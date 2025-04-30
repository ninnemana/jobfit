#!/bin/sh
set -e

# Install buf CLI if not present
if ! command -v buf >/dev/null 2>&1; then
  echo "Installing buf CLI..."
  go install github.com/bufbuild/buf/cmd/buf@latest
fi

# Install protoc-gen-go if not present
if ! command -v protoc-gen-go >/dev/null 2>&1; then
  echo "Installing protoc-gen-go..."
  go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
fi

# Install protoc-gen-go-grpc if not present
if ! command -v protoc-gen-go-grpc >/dev/null 2>&1; then
  echo "Installing protoc-gen-go-grpc..."
  go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
fi

# Run buf generate
echo "Running buf generate..."
buf generate 
