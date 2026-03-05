#!/bin/sh
set -eu

case "${CKAN__PLUGINS:-}" in
  *datapusher*)
  # Keep ckan.datapusher.api_token synchronized with runtime env to avoid
  # leaving the default placeholder value ("xxx"), which causes 403 errors
  # when DataPusher writes to the DataStore API.
  if [ -n "${CKAN__DATAPUSHER__API_TOKEN:-}" ]; then
    ckan config-tool "$CKAN_INI" "ckan.datapusher.api_token=${CKAN__DATAPUSHER__API_TOKEN}"
  else
    echo "Set up ckan.datapusher.api_token in the CKAN config file"
    TOKEN="$(ckan -c "$CKAN_INI" user token add ckan_admin datapusher 2>/dev/null | grep -Eo '[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+' | head -n 1)"
    if [ -n "$TOKEN" ]; then
      ckan config-tool "$CKAN_INI" "ckan.datapusher.api_token=$TOKEN"
    fi
  fi
  ;;
  *)
  echo "Not configuring DataPusher"
  ;;
esac
