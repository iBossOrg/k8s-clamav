### BASE_IMAGE #################################################################

BASE_IMAGE_NAME		?= $(DOCKER_VENDOR)/alpine
BASE_IMAGE_TAG		?= 3

### DOCKER_IMAGE ###############################################################

DOCKER_VENDOR		?= iboss
DOCKER_NAME		?= clamav
DOCKER_IMAGE_TAG	?= 0.102.1
DOCKER_IMAGE_TAGS	?= latest
DOCKER_IMAGE_DESC	?= ClamAV antivirus engine
DOCKER_IMAGE_URL	?= https://www.clamav.net

### MAKE_TARGETS ###############################################################

# Build a new image and run the tests
.PHONY: all
all: image clean

# Build an image, run tests and delete all containers and work files
.PHONY: image
image: _clean build start wait logs test

### BUILD_TARGETS ##############################################################

# Build a new image with using the Docker layer caching
.PHONY: build
build: docker-build

# Build a new image without using the Docker layer caching
.PHONY: rebuild
rebuild: docker-rebuild

### EXECUTOR_TARGETS ###########################################################

# Display the make variables
.PHONY: vars
vars: docker-makevars

# Remove the containers and then run them fresh
.PHONY: run up
run up: docker-up

# Create the containers
.PHONY: create
create: docker-create

# Start the containers
.PHONY: start
start: docker-start

# Wait for the start of the containers
.PHONY: wait
wait: docker-wait

# Display running containers
.PHONY: ps
ps: docker-ps

# Display the container logs
.PHONY: logs
logs: docker-logs

# Follow the container logs
.PHONY: tail
tail: docker-logs-tail

# Run shell in the container
.PHONY: sh
sh: docker-shell

# Run the tests
.PHONY: test
test: docker-test

# Run the shell in the test container
.PHONY: tsh
tsh:
	@$(MAKE) test TEST_CMD=/bin/bash RSPEC_FORMAT=documentation

# Restart the containers
.PHONY: restart
restart: docker-restart

# Stop the containers
.PHONY: stop
stop: docker-stop

# Delete the containers
.PHONY: down rm
down rm: docker-rm

# Delete all containers and work files
.PHONY: clean
clean: docker-clean

# Helper that gives the opportunity to call the clean target twice
.PHONY: _clean
_clean:
	@$(MAKE) docker-clean

### MK_DOCKER_IMAGE ############################################################

BUILD_DIR		?= $(CURDIR)
PROJECT_DIR		?= $(BUILD_DIR)/..
MK_DIR			?= $(PROJECT_DIR)/../Mk
include $(MK_DIR)/docker.image.mk

################################################################################
