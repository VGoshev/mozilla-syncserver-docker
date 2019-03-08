FROM alpine:3.9
MAINTAINER Vladimir Goshev <sunx@sunx.name>

# DATA_DIR:
# Where we will store config and db.
#  Also it's user home directory.
# Default: /home/ffsync
#
# GIT_COMMIT:
# Git commit hash from 
#  https://github.com/mozilla-services/syncserver
#  which we want to use for our Mozilla Syncserver
# uUID - set UID of ffsync user, default: 2016
# uGID - set GID of ffsync user, default: 2016
ENV DATA_DIR="/home/ffsync" \
	GIT_COMMIT="12af274dafdef9887e420671bbed09b3099ad546"

# Whole installation process is in build.sh
# It is possible to do all work via RUN command(s)
# But it looks much better with all work in script
COPY build.sh /tmp/build.sh
# Execute our build script and delete it because we won't need it anymore
RUN /tmp/build.sh "$GIT_COMMIT" "$DATA_DIR" && rm /tmp/build.sh


COPY syncserver.ini /usr/local/share/syncserver.ini
# Container initialization scripts
COPY docker-run docker-run-root /bin/

#EXPOSE 5000
#VOLUME $DATA_DIR

# Container will run some preparations with root access (fixing permissions, for example)
#   and then execute /bin/docker-run with user access to configure (if needed) and run
#		Syncserver
CMD ["/bin/docker-run-root"]
