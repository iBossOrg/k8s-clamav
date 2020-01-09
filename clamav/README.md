# ClamAV Docker image

[ClamAV](https://www.clamav.net/) antivirus engine:

* [Alpine Linux](https://github-com/iBossOrg/k8s-alpine) as a base system.
* [ClamAV](https://www.clamav.net/) as an antivirus engine.

## Usage

You can start with this sample `docker-compose.yml` file:

```yaml
services:
  clamd:
    image: iboss/clamav
    depends_on:
      - freshclam
    environment:
      - CLAMAV_UPDATE=true
    ports:
      - 3310:3310
    volumes:
      - clamav_data:/var/lib/clamav
  freshclam:
    image: iboss/clamav
    command: freshclam --daemon
    environment:
      - CLAMAV_HOST=clamd
      - WAIT_FOR_TCP=clamd:3310
      - WAIT_FOR_TIMEOUT=300
    volumes:
      - clamav_data:/var/lib/clamav
volumes:
  clamav_data:
```

### Environment variables

| Variable | Default value | Description |
| -------- | ------------- | ----------- |
| DEFAULT_COMMAND | `/usr/sbin/clamd` | The default Docker command if the first argument is an option (-o or --option). |
| CLAMAV_UPDATE | Not set. | If set to any value, freshclam is started first and updates the virus database. |
| CLAMAV_UPDATE_OPTS | Not set. | Parameters for freshclam. |

### Health probe

Health probe script `/service/health` use ClamAV PING/PONG command to test ClamAV daemon.

**NOTE: When a ClamAV daemon reloads a virus database, the health probe may wait up to 30 seconds to complete.**

| Argument | Default value | Description |
| -------- | ------------- | ----------- |
| 1 | localhost | ClamAV daemon IP address. |
| 2 | 3310 | ClamAV daemon TCP port. |

## Contributing

Use the command `make`:

```bash
make all                      # Build an image and run tests
make image                    # Build an image, run tests and delete all containers and work files
make build                    # Build an image
make rebuild                  # Build an image without using Docker layer caching
make vars                     # Show the make variables
make up                       # Delete the containers and then run them fresh
make create                   # Create the containers
make start                    # Start the containers
make wait                     # Wait for the containers to start
make ps                       # List running containers
make logs                     # Show the container logs
make tail                     # Follow the container logs
make sh                       # Run the shell in the container
make test                     # Run the tests
make tsh                      # Run the shell in the test container
make restart                  # Restart the containers
make stop                     # Stop the containers
make down                     # Delete the containers
make clean                    # Delete all running containers and work files
make docker-pull              # Pull all images from the Docker Registry
make docker-pull-dependencies # Pull the project image dependencies from the Docker Registry
make docker-pull-image        # Pull the project image from the Docker Registry
make docker-pull-testimage    # Pull the test image from the Docker Registry
make docker-push              # Push the project image into the Docker Registry
```

Please read the [Contribution Guidelines](CONTRIBUTING.md), and ensure you are signing all your commits with [DCO sign-off](CONTRIBUTING.md#developer-certification-of-origin-dco).
