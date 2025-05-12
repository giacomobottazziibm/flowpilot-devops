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


echo "Using Redis: $DB_PROXY_REDIS_URI"

export NEXT_TELEMETRY_DISABLED=1

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

if [[ ! -e $FLOPILOT_HOME/tmp/ui.pid ]]; then   # Check if the file already exists
 
	echo "Starting UI"
	node $FLOPILOT_HOME/ui/.next/standalone/server.js > $FLOPILOT_HOME/logs/ui.log &

	echo $! > $FLOPILOT_HOME/tmp/ui.pid

	echo "UI started"


else
    echo -n "ERROR: The UI process is already running with pid "
    cat $FLOPILOT_HOME/tmp/ui.pid
    echo
fi

}

stop()
{

if [[ -e $FLOPILOT_HOME/tmp/ui.pid ]]; then   # If the file do not exists, then the
    kill -9 `cat $FLOPILOT_HOME/tmp/ui.pid`      #+the process is not running. Useless
    rm $FLOPILOT_HOME/tmp/ui.pid              #+trying to kill it.
else
    echo "UI is not running"
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