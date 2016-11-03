#!/bin/sh
#Run seafile docker container with host folder as a volume

#Default volume path on host.
VOLUME_PATH="/home/docker/ff-sync"
#Container hostname
CONTAINER_HOSTNAME="ff-sync.domain.com"
#Container name
CONTAINER_NAME="ff-sync"
#Restart policy
RESTART_POLCY="unless-stopped"
#Some extra arguments. Like -d ant -ti
EXTRA_ARGS="-d -ti"
#docker command. You can use "sudo docker" if you need so
DOCKER="docker"
#Extra args to docker command. Like using remote dockerd or something else
DOCKER_ARGS=""

#You can change default values by adding them to config file ~/.docker-sunx-ffsync
[ -f ~/.docker-sunx-ffsync ] && . ~/.docker-sunx-ffsync

[ ! -z "$CONTAINER_HOSTNAME" ] && CONTAINER_HOSTNAME="--hostname=$CONTAINER_HOSTNAME"
[ ! -z "$CONTAINER_NAME" ]     && CONTAINER_NAME="--name=$CONTAINER_NAME"
[ ! -z "$RESTART_POLCY" ]      && RESTART_POLCY="--restart=$RESTART_POLCY"

$DOCKER $DOCKER_ARGS run \
	-v $VOLUME_PATH:/home/ffsync \
	-p 127.0.0.1:5000:5000 \
	$CONTAINER_HOSTNAME \
	$CONTAINER_NAME \
	$RESTART_POLCY \
	$EXTRA_ARGS \
	sunx/mozilla-syncserver
