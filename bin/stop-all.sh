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

$FLOPILOT_HOME/bin/ui.sh stop
$FLOPILOT_HOME/bin/db.sh stop
$FLOPILOT_HOME/bin/evaluator.sh stop
$FLOPILOT_HOME/bin/api.sh stop
