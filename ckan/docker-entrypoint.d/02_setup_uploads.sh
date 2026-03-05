#!/bin/sh
set -eu

# Ensure upload visibility is deterministic across container recreations.
# Some setups keep ckan.uploads_enabled present but empty in ckan.ini, which
# CKAN evaluates as disabled in the UI.
if [ -n "${CKAN__UPLOADS_ENABLED:-}" ]; then
  ckan config-tool "$CKAN_INI" "ckan.uploads_enabled=${CKAN__UPLOADS_ENABLED}"
elif [ -n "${CKAN_STORAGE_PATH:-}" ]; then
  ckan config-tool "$CKAN_INI" "ckan.uploads_enabled=true"
fi
