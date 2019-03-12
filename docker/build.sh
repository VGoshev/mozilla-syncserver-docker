#!/bin/sh -e

#Debug!
set -x

# Fix little bug in alpine image
#ln -s /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh

###################################################
# We'll need binaries from different paths,       #
#  so we should be sure, all bin dir in the PATH  #
###################################################
PATH="${PATH}:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

#########################################################
# Get Mozilla Syncserver Git commit hash from first arg #
#########################################################
GIT_COMMIT="b57a109c7aa708a664fe487080603874bed4c35d"
if [ "x$1" != "x" ]; then
    GIT_COMMIT=$1
fi

#################################
# Where all data will be stored #
#################################
DATA_DIR="/home/ffsync"
if [ "x$2" != "x" ]; then
    DATA_DIR=$2
fi

WORK_DIR="/tmp/build"
mkdir -p $WORK_DIR
cd $WORK_DIR

################################
# UID and GID for ffsync user #
################################
[ -z "$uUID" ] && uUID=2016
[ -z "$uGID" ] && uGID=2016


################################
# Install some needed packages #
################################
apk update
###############################################
# Runtime dependencies for Mozilla Syncserver #
###############################################
apk add python py-pip libstdc++ libffi openssl su-exec
pip install PyMySQL

#################################################
# Add build-deps                                #
#################################################
apk add --virtual .build_dep \
	python-dev make gcc g++ git libffi-dev openssl-dev
#py2-virtualenv

################################################
# Clone mozilla-syncserv and get needed commit #
################################################
git clone https://github.com/mozilla-services/syncserver.git .
git reset --hard "$GIT_COMMIT"

##############################
# Build and install syncserv #
##############################
echo '#!/bin/sh' > /usr/local/bin/virtualenv
chmod +x /usr/local/bin/virtualenv
mkdir ./local
ln -s /usr/bin ./local/
sed -i.bak -e 's,^\s*VIRTUALENV\s*=.*$,VIRTUALENV = /bin/echo,' Makefile
make build
rm /usr/local/bin/virtualenv

# StackOverflow-driven development as it is: 
#   http://stackoverflow.com/questions/122327/how-do-i-find-the-location-of-my-python-site-packages-directory
PYTHON_PACKAGES_DIR=`python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`
cp -rf syncserver.egg-info syncserver $PYTHON_PACKAGES_DIR
#cp syncserver.ini /usr/local/share/

########################
# Do some preparations #
# Like add ffsync user #
########################

addgroup -g "$uGID" ffsync
adduser -D -s /bin/sh -g "Mozilla Syncserver" -G ffsync -h "$DATA_DIR" -u "$uUID" ffsync

#########################################
# Delete all unneded files and packages #
#########################################
cd /
apk del --purge .build_dep
rm /var/cache/apk/*
rm -rf /root/.cache
rm -rf $WORK_DIR

echo "Done!"
