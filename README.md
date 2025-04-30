# JobFit

[![Coverage Status](https://coveralls.io/repos/github/ninnemana/jobfit/badge.svg?branch=main)](https://coveralls.io/github/ninnemana/jobfit?branch=main)

A Go-based service for job matching and analysis.

## Project Structure

```
.
├── api/
│   └── jobfit/
│       └── v1/           # Protocol Buffer definitions
├── .github/
│   └── workflows/        # GitHub Actions CI/CD workflows
│   └── dependabot.yml    # Dependabot configuration
├── buf.yaml             # Buf configuration for linting and breaking changes
├── buf.gen.yaml         # Buf code generation configuration
├── buf.work.yaml        # Buf workspace configuration
├── .golangci.yml        # Golang linter configuration
└── main.go              # Main application entry point
```

## Prerequisites

- Go 1.24 or later
- [buf](https://buf.build/docs/installation) CLI tool
- Protocol Buffer plugins for Go

## Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/ninnemana/jobfit.git
   cd jobfit
   ```

2. Install dependencies:
   ```bash
   go mod tidy
   ```

3. Generate code from Protocol Buffers:
   ```bash
   go generate ./...
   ```

   This will automatically:
   - Install the buf CLI if not present
   - Install required protoc plugins for Go
   - Generate Go code from your .proto files

## Code Generation

The project uses [buf](https://buf.build) for managing Protocol Buffers and generating Go code. The configuration is split across several files:

- `buf.yaml`: Defines linting and breaking change detection rules
- `buf.gen.yaml`: Configures code generation options and output paths
- `buf.work.yaml`: Defines the workspace structure for proto files

### Generated Code

All generated code is placed in the `api/joblift/v1/` directory with the following structure:
- Go protobuf code
- gRPC service definitions

The generation process is automated via Go's generate tool. To regenerate code after making changes to .proto files, run:

```bash
go generate ./...
```

## Development Workflow

1. Define your services in `api/jobfit/v1/*.proto`
2. Run code generation: `go generate ./...`
3. Implement your services using the generated interfaces
4. Build and test your implementation

## Continuous Integration

The project uses GitHub Actions for continuous integration with two main workflows:

### Go Workflow
Triggered on every pull request:
- Runs `golangci-lint` for code quality checks
- Executes `go vet` for static analysis
- Runs Gosec security scanner
- Executes all tests with race condition detection
- Uploads test coverage to Coveralls
- Performs CodeQL security analysis

### Protocol Buffer Workflow
Triggered on every pull request:
- Lints all `.proto` files using buf
- Checks for breaking changes when merging to main branch
- Ensures Protocol Buffer best practices are followed
- Reports issues to GitHub code scanning

### Security Scanning
All security scanning results are available in GitHub's Security tab:
- CodeQL analysis for Go code
- Gosec security scanning
- Protocol Buffer security checks
- Breaking changes detection

### Code Coverage
Code coverage is tracked by [Coveralls](https://coveralls.io/github/ninnemana/jobfit):
- Coverage trends over time
- Per-file coverage analysis
- Coverage status checks on PRs

### Dependency Management
The project uses Dependabot to automatically update dependencies:

- **Daily Checks**: Dependabot checks for updates every day
- **Automated Updates**: Updates are automatically merged if they pass all checks
- **Monitored Dependencies**:
  - Go modules
  - GitHub Actions
  - Docker images
- **Update Strategy**:
  - Minor and patch updates are grouped and auto-merged
  - Major updates require manual review
  - Dependencies are labeled for easy tracking

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

Your pull request will automatically trigger:
- Code quality checks
- Security scanning
- Test execution with coverage reporting
- Protocol Buffer linting
- Breaking change detection

## License

This project is licensed under the MIT License - see the LICENSE file for details.
