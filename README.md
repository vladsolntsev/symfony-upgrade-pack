# Symfony Project

This is a Symfony template with a Docker environment and quality assurance/testing tools.

It uses the following tools:
- PHP CS Fixer
- PHPStan
- PHPUnit
- Rector
- Bruno API

## Prerequisites

- Docker and Docker Compose
- PHP 8.3

## Installation

Clone the repository and install dependencies:

```bash
git clone ...
cd symfony-upgrade-pack
make build
```

## Available Commands

### Docker Environment

```bash
make start      # Start Docker containers
make stop       # Stop Docker containers
make restart    # Restart Docker containers
```

### Development

```bash
make build      # Validate composer.json and install dependencies
```

### Quality Checks

```bash
make quality     # Run all quality checks (CS fixer, PHPStan, Rector)
make cs-fixer    # Run PHP-CS-Fixer
make phpstan     # Run PHPStan static analysis
make rector      # Run Rector
```

### Tests

```bash
make tests                # Run PHPUnit tests
make tests-with-coverage  # Run PHPUnit tests with coverage reports
make api-tests            # Run Bruno API tests
make tests-all            # Run all tests (unit, API, and quality checks)
```

## Continuous Integration

This project uses GitHub Actions for continuous integration with the following steps:

- Build the project
- Quality checks (CS Fixer, PHPStan, Rector)
- Unit tests with coverage
- API tests
