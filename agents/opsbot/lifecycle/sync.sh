#!/bin/bash
set -euo pipefail

DATA_PATH=${1}
SOURCE_PATH=${2:-.}/agents/opsbot

# workspace
echo "syncing workspace data from ${SOURCE_PATH}/workspace to ${DATA_PATH}/workspace"
rsync -av --delete --include='*.md' --include='skills/' --include='skills/**' --exclude='*' "${SOURCE_PATH}/workspace/" "${DATA_PATH}/workspace/"
printf "\n"

# configuration
echo "syncing configuration from ${SOURCE_PATH}/config.json to ${DATA_PATH}/config.json"
cp "${SOURCE_PATH}/config.json" "${DATA_PATH}/config.json"

# security
SECURITY_SRC="/security/security.yml"
if [[ -f "${SECURITY_SRC}" ]]; then
  echo "syncing security from ${SECURITY_SRC} to ${DATA_PATH}/security.yml"
  cp "${SECURITY_SRC}" "${DATA_PATH}/security.yml"
else
  echo "skipping security sync: ${SECURITY_SRC} not found"
fi
