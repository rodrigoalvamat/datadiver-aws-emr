#!/bin/bash

# get the full path of the script and its directory
SCRIPT_PATH="${BASH_SOURCE}"
while [ -L "${SCRIPT_PATH}" ]; do
  SCRIPT_DIR="$(cd -P "$(dirname "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"
  SCRIPT_PATH="$(readlink "${SCRIPT_PATH}")"
  [[ ${SCRIPT_PATH} != /* ]] && SCRIPT_PATH="${SCRIPT_DIR}/${SCRIPT_PATH}"
done
SCRIPT_PATH="$(readlink -f "${SCRIPT_PATH}")"
SCRIPT_DIR="$(cd -P "$(dirname -- "${SCRIPT_PATH}")" >/dev/null 2>&1 && pwd)"

# reads project config
PROJECT_DIR=""${SCRIPT_DIR}"/.."
source <(grep = "$PROJECT_DIR"/emr.cfg)

# copy the ssh key pair .pem file to the ERM cluster $HOME folder
scp -i "$KEYPAIR" "$KEYPAIR" "hadoop@$DNS:/home/hadoop/"