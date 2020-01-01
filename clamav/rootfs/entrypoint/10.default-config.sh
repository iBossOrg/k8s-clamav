#!/bin/bash -e

### DEFAULT_CONFIG #############################################################

# The default Docker command if the first argument is an option (-o or --option)
: ${DEFAULT_COMMAND:="/usr/sbin/clamd"}

# Run as clamav user
if [ "${EUID}" -eq 0 ]; then
  : ${RUN_AS_USER:=clamav}
  : ${RUN_AS_GROUP:=clamav}
fi

################################################################################
