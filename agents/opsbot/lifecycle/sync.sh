#!/bin/bash
set -euo pipefail

DATA_PATH=${1}
SOURCE_PATH=${2:-.}/agents/opsbot

CONFIG_FILE_NAME="config.json"
CONFIG_FILE_TEMPLATE_NAME="config.json.tpl"

# 0. Setup Template
rsync -a "${SOURCE_PATH}/${CONFIG_FILE_NAME}" "${SOURCE_PATH}/${CONFIG_FILE_TEMPLATE_NAME}"

# 1. Identify changes
# -n: dry-run, -i: itemize, -m: prune empty dirs
CHANGES=$(rsync -rcnm --out-format="%n" \
  --include='workspace/' \
  --include='workspace/*.md' \
  --include='workspace/skills/' \
  --include='workspace/skills/**' \
  --include=${CONFIG_FILE_TEMPLATE_NAME} \
  --exclude='*' \
  "$SOURCE_PATH/" "$DATA_PATH/" || true)

# 2. Check for Changes
if [ -z "$CHANGES" ]; then
    echo "no changes have been found"
    exit 0
fi
echo "changes detected:"
echo "$CHANGES"
printf "\n"

# 3. Sync Workspace ONLY if files other than config.json changed
if echo "$CHANGES" | grep -qv "${CONFIG_FILE_TEMPLATE_NAME}"; then
  echo "syncing workspace data from ${SOURCE_PATH}/workspace to ${DATA_PATH}/workspace"
  rsync -a --delete \
    --include='workspace/' \
    --include='workspace/*.md' \
    --include='workspace/skills/' \
    --include='workspace/skills/**' \
    --exclude='*' \
    "$SOURCE_PATH/" "$DATA_PATH/"
fi

# 4. Handle Configuration
if echo "$CHANGES" | grep -q "${CONFIG_FILE_TEMPLATE_NAME}"; then
  echo "syncing configuration from ${SOURCE_PATH}/${CONFIG_FILE_TEMPLATE_NAME} to ${DATA_PATH}/${CONFIG_FILE_NAME}"
  rsync -a --include="${CONFIG_FILE_TEMPLATE_NAME}" --exclude='*' "$SOURCE_PATH/" "$DATA_PATH/"
  envsubst < "${SOURCE_PATH}/${CONFIG_FILE_TEMPLATE_NAME}" > "${DATA_PATH}/${CONFIG_FILE_NAME}"
fi
