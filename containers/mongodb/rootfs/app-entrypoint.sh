#!/bin/bash
set -e

if [[ "$1" == "harpoon" && "$2" == "start" ]]; then
  status=`harpoon inspect $BITNAMI_APP_NAME`
  if [[ "$status" == *'"lifecycle": "unpacked"'* ]]; then
    harpoon initialize $BITNAMI_APP_NAME \
      ${MONGODB_USER:+--username $MONGODB_USER} \
      ${MONGODB_PASSWORD:+--password $MONGODB_PASSWORD}
  fi
fi

chown $BITNAMI_APP_USER: /bitnami/$BITNAMI_APP_NAME || true

exec /entrypoint.sh "$@"
