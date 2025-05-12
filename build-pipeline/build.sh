#!/bin/bash
# 
# Licensed Materials - Property of IBM
# 5900-AEO
# Copyright IBM Corp.  2025.
# U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
# 
BUILD_DIR=/Users/giacomobottazzi/htdocs/flowpilot/flowpilot-devops/build-pipeline


mkdir ./src/text2sql
git clone git@github.ibm.com:nl2insights/text2sql.git ./src/text2sql
git pull

mkdir ./src/api
git clone git@github.ibm.com:nl2insights/api.git ./src/api
git pull

mkdir ./src/db
git clone git@github.ibm.com:flowpilot/db-service.git ./src/db
git pull

mkdir ./src/evaluator
git clone git@github.ibm.com:flowpilot/evaluator-service.git ./src/evaluator
git pull

mkdir ./src/ui
git clone git@github.ibm.com:flowpilot/ui.git ./src/ui
git pull

podman run -it \
-v $BUILD_DIR/src:/src \
-v $BUILD_DIR/dist:/dist  \
flowpilot-build-base /bin/bash