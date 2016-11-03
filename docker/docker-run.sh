#!/bin/sh
#set -x

CONFIG_FILE="syncserver.ini"
DB_FILE="syncserver.db"

cd $HOME

if [ ! -e "$CONFIG_FILE" ]; then
	cp /usr/local/share/$CONFIG_FILE ./$CONFIG_FILE
	SECRET=`head -c 20 /dev/urandom | sha1sum | awk '{print $1}'`
	echo "secret = $SECRET" >> ./$CONFIG_FILE
	echo "sqluri = sqlite:///$HOME/$DB_FILE" >> ./$CONFIG_FILE
fi

exec gunicorn --paste "$HOME/$CONFIG_FILE"
