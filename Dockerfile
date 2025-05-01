# syntax=docker/dockerfile:1

# Build stage
FROM golang:1.24-alpine AS builder

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache git build-base

# Install buf and protoc plugins
RUN go install github.com/bufbuild/buf/cmd/buf@latest && \
    go install google.golang.org/protobuf/cmd/protoc-gen-go@latest && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# Copy go mod files
COPY go.mod ./
COPY go.sum ./
RUN go mod download

# Copy the rest of the source code
COPY . .

# Generate protobuf code
RUN buf generate

# Build the application
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /app/jobfit

# Final stage
FROM gcr.io/distroless/static-debian12

WORKDIR /app

# Copy the binary from builder
COPY --from=builder /app/jobfit .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["/app/jobfit"] 
