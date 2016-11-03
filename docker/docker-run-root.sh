#!/bin/sh
#set -x
#Fix user home directory permissions 
#  if needed and exec docker-run script

RUN_USER="ffsync"
USER_DIR=`eval echo "~$RUN_USER"`

DIR_OWNER=`stat -c '%U' "$USER_DIR"`

if [ "$DIR_OWNER" != "$RUN_USER" ]; then
	chown -R "$RUN_USER:$RUN_USER" "$USER_DIR"
fi

exec su -l -c 'exec /bin/docker-run' $RUN_USER
