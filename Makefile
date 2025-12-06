# Fizzy Docker Makefile

.PHONY: help build run update stop logs shell clean init

# Default target
help:
	@echo "Fizzy Docker Commands:"
	@echo ""
	@echo "  make build    - Build Docker image"
	@echo "  make run      - Build and run application"
	@echo "  make update    - Git pull, build and run"
	@echo "  make stop      - Stop application"
	@echo "  make logs      - Show application logs"
	@echo "  make shell     - Access container shell"
	@echo "  make clean     - Clean up containers and images"
	@echo ""
	@echo "Environment:"
	@echo "  Make sure .env file exists with RAILS_MASTER_KEY"

# Build Docker image
build:
	@echo "🔨 Building Fizzy Docker image..."
	docker build -t fizzy:latest .

# Run application
run: build
	@echo "🚀 Starting Fizzy application..."
	docker-compose up -d
	@echo "✅ Fizzy is running"

# Update and run
update:
	@echo "📥 Updating Fizzy..."
	git pull
	@echo "🔨 Rebuilding image..."
	$(MAKE) build
	@echo "🚀 Restarting application..."
	docker-compose up -d --force-recreate
	@echo "✅ Fizzy updated and running"

# Stop application
stop:
	@echo "⏹️  Stopping Fizzy..."
	docker-compose down
	@echo "✅ Fizzy stopped"

# Show logs
logs:
	docker-compose logs -f fizzy

# Access shell
shell:
	docker-compose exec fizzy bash

# Clean up
clean:
	@echo "🧹 Cleaning up..."
	docker-compose down -v
	docker rmi fizzy:latest 2>/dev/null || true
	docker system prune -f
	@echo "✅ Cleanup complete"
