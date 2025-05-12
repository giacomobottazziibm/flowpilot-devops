#!/bin/bash
# 
# Licensed Materials - Property of IBM
# 5900-AEO
# Copyright IBM Corp.  2025.
# U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
# 


poetry config http-basic.nl2insights_pypi $P_USERNAME

rm -Rf /dist/flowpilot
mkdir /dist/flowpilot

compile-py.sh
compile-ui.sh

# bin
cp -R bin /dist/flowpilot
mkdir /dist/flowpilot/logs
mkdir /dist/flowpilot/tmp

cd /dist
tar cvf flowpilot.tar /flowpilot