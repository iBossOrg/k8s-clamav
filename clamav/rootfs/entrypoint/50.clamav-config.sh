#!/bin/bash -e

### CLAMAV_CONFIG ##############################################################

# Setup remote ClamAV daemon address
if [ -n "${CLAMAV_HOST}" ]; then
  info "Setting ClamAV deamon address to '${CLAMAV_HOST}'"
  echo "TCPAddr ${CLAMAV_HOST}" >> /etc/clamav/clamd.conf
fi

################################################################################
