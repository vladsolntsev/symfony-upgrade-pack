.PHONY: start stop restart build \
        tests tests-with-coverage api-tests tests-all \
        cs-fixer phpstan rector quality \
        security help

help:
	@echo "start                - Start Docker containers"
	@echo "stop                 - Stop Docker containers"
	@echo "restart              - Restart Docker containers"
	@echo "build                - Validate composer.json and install dependencies"
	@echo "tests                - Run PHPUnit tests"
	@echo "tests-with-coverage  - Run PHPUnit tests with coverage reports"
	@echo "api-tests            - Run Bruno API tests"
	@echo "tests-all            - Run all tests (unit, API, and quality checks)"
	@echo "quality              - Run all quality checks (CS fixer, PHPStan, Rector)"
	@echo "cs-fixer             - Run PHP-CS-Fixer"
	@echo "phpstan              - Run PHPStan static analysis"
	@echo "rector               - Run Rector"
	@echo "security             - Run security check on dependencies"

start:
	docker compose -f deploy/docker-compose.yml up -d

stop:
	docker compose -f deploy/docker-compose.yml down

restart: stop start

build:
	composer validate --strict
	composer install --prefer-dist --no-progress

tests:
	vendor/bin/phpunit --configuration phpunit.dist.xml

tests-with-coverage:
	mkdir -p coverage
	vendor/bin/phpunit --configuration phpunit.dist.xml --coverage-text --coverage-xml=coverage/xml

api-tests:
	npm install -g @usebruno/cli
	php -S localhost:8000 -t public &
	sleep 2
	cd bruno && bru run --env dev

tests-all: quality tests api-tests

cs-fixer:
	vendor/bin/php-cs-fixer fix --dry-run --diff

phpstan:
	vendor/bin/phpstan analyse -c phpstan.dist.neon

rector:
	vendor/bin/rector process --dry-run

quality: cs-fixer phpstan rector

security:
	composer audit

