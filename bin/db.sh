#!/bin/bash
# 
# Licensed Materials - Property of IBM
# 5900-AEO
# Copyright IBM Corp.  2025.
# U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
# 


CONFIG=environment.conf

PRG="$0"
PRG=$(readlink -fe ${PRG})
PRGDIR=`dirname "$PRG"`

source "$PRGDIR/$CONFIG"
test -f "/etc/$CONFIG" && source "/etc/$CONFIG"

export UPLOADS_PATH
export DB_PROXY_REDIS_URI

echo "Using UPLOADS_PATH: $UPLOADS_PATH"
echo "Using DB_PROXY_REDIS_URI: $DB_PROXY_REDIS_URI"


usage()
{
    echo "Usage: ${0##*/} [-d] {start|run|stop|restart}"
    exit 1
}
[ $# -gt 0 ] || usage

ACTION=$1
#shift


start()
{

if [[ ! -e $FLOPILOT_HOME/tmp/db.pid ]]; then   # Check if the file already exists
 

	echo "Starting DB  service"
	cd $FLOPILOT_HOME/db-service
	poetry run python -m database_proxy_service.main &> $FLOPILOT_HOME/logs/db-service.log & 
	echo "DB server started"

	echo $! > $FLOPILOT_HOME/tmp/db.pid


else
    echo -n "ERROR: The DB service process is already running with pid "
    cat $FLOPILOT_HOME/tmp/db.pid
    echo
fi

}

stop()
{

if [[ -e $FLOPILOT_HOME/tmp/db.pid ]]; then   # If the file do not exists, then the
    kill -9 `cat $FLOPILOT_HOME/tmp/db.pid`      #+the process is not running. Useless
    rm $FLOPILOT_HOME/tmp/db.pid              #+trying to kill it.
else
    echo "DB service is not running"
fi

}


case "$ACTION" in
  restart)
    stop
    start
    ;;
  start|run)
    start
    ;;
  stop)
    stop
    ;;
  *)
    usage

    ;;
esac


