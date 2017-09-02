#!/bin/sh
#set -x

CONFIG_FILE="syncserver.ini"
DB_FILE="syncserver.db"

cd $HOME

if [ ! -e "$CONFIG_FILE" ]; then
#	cp /usr/local/share/$CONFIG_FILE ./$CONFIG_FILE
	SECRET=`head -c 20 /dev/urandom | sha1sum | awk '{print $1}'`
	HOSTNAME=`hostname`
	[ -z "$PUBLIC_URL" ] && PUBLIC_URL="http://$HOSTNAME/"
	SQLURI="sqlite:///$HOME/$DB_FILE"

	cat /usr/local/share/$CONFIG_FILE | \
		sed "/^\s*secret\s*=/s,=.*,= $SECRET," |
		sed "/^\s*sqluri\s*=/s,=.*,= $SQLURI," |
		sed "/^\s*public_url\s*=/s,=.*,= $PUBLIC_URL," > ./$CONFIG_FILE
fi

exec gunicorn --paste "$HOME/$CONFIG_FILE"
