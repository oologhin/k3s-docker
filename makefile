# Variables
IMAGE_NAME = ubuntu-k3s
CONTAINER_NAME = ubuntu-k3s
SSH_PORT = 2222

# Targets
all: build run

build:
	@echo "Building Docker image..."
	docker build --no-cache -t $(IMAGE_NAME) .

run: stop
	@echo "Running Docker container..."
	docker run --privileged -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p $(SSH_PORT):$(SSH_PORT) --name $(CONTAINER_NAME) -v $(PWD):/workspace $(IMAGE_NAME)

stop:
	@echo "Stopping and removing any existing container..."
	-docker rm -f $(CONTAINER_NAME)

clean: stop
	@echo "Removing Docker image..."
	-docker rmi $(IMAGE_NAME)

exec:
	@echo "Accessing the running container..."
	docker exec -it $(CONTAINER_NAME) bash

.PHONY: all build run stop clean exec
