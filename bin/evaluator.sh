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

if [[ ! -e $FLOPILOT_HOME/tmp/evaluator.pid ]]; then   # Check if the file already exists
 
	PYTHONPATH=/home/ubuntu/.cache/pypoetry/virtualenvs/evaluator-service-4ApNwGWJ-py3.12/lib/python3.12/site-packages/

	cd $FLOPILOT_HOME/evaluator-service

	# Add src directory to PYTHONPATH
	export PYTHONPATH="${PYTHONPATH:+${PYTHONPATH}:}$FLOPILOT_HOME/evaluator-service/src"

	# Run uvicorn using poetry
	python3 -m evaluator_service.main &> $FLOPILOT_HOME/logs/evaluator.log & 
	echo "Evaluator server started"

	echo $! > $FLOPILOT_HOME/tmp/evaluator.pid



else
    echo -n "ERROR: The Evaluator service process is already running with pid "
    cat $FLOPILOT_HOME/tmp/evaluator.pid
    echo
fi

}

stop()
{

if [[ -e $FLOPILOT_HOME/tmp/evaluator.pid ]]; then   # If the file do not exists, then the
    kill -9 `cat $FLOPILOT_HOME/tmp/evaluator.pid`      #+the process is not running. Useless
    rm $FLOPILOT_HOME/tmp/evaluator.pid              #+trying to kill it.
else
    echo "Evaluator service is not running"
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



