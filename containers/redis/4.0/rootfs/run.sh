#!/bin/bash
. /opt/bitnami/base/functions
. /opt/bitnami/base/helpers

USER=redis
DAEMON=redis-server
EXEC=$(which $DAEMON)
ARGS="/opt/bitnami/redis/conf/redis.conf --daemonize no"

# log output to stdout
sed -i 's/^logfile /# logfile /g' /opt/bitnami/redis/conf/redis.conf

# If container is started as `root` user
if [ $EUID -eq 0 ]; then
    exec gosu ${USER} ${EXEC} ${ARGS}
else
    exec ${EXEC} ${ARGS}
fi
