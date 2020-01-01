#!/bin/bash -e

### CLAMAV_UPDATE ##############################################################

# Update ClamAV database
if [ -n "${CLAMAV_UPDATE}" ]; then
  info "Updating ClamAV database"
  /usr/bin/freshclam ${CLAMAV_UPDATE_OPTS}
fi

################################################################################
