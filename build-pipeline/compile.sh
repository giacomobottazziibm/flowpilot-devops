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

cd /src/text2sql
poetry install
poetry build
python3 -m pip install dist/text2sql-1.2.18-py3-none-any.whl

cd /src/api
poetry install
poetry build
python3 -m pip install dist/api-0.0.2-py3-none-any.whl
mkdir ./tmp
python3 -m pip freeze --all  >./tmp/custom-requisites.txt
#grep -v -e "api" ./tmp/custom-requisites.txt > ./tmp/requisites.txt
python3 -m pip wheel  --wheel-dir=/dist/flowpilot/nl2insights_api -r ./tmp/requisites.txt

cd /src/db
poetry install
poetry build
python3 -m pip install dist/database_proxy_service-0.0.1-py3-none-any.whl
mkdir ./tmp
python3 -m pip freeze --all  >./tmp/custom-requisites.txt
grep -v -e "database_proxy_service" ./tmp/custom-requisites.txt > ./tmp/requisites.txt
python3 -m pip wheel  --wheel-dir=/dist/flowpilot/db-service -r ./tmp/requisites.txt


cd /src/evaluator
poetry install
poetry build
python3 -m pip install dist/evaluator_service-0.0.1-py3-none-any.whl
mkdir ./tmp
python3 -m pip freeze --all  >./tmp/custom-requisites.txt
grep -v -e "evaluator_service" ./tmp/custom-requisites.txt > ./tmp/requisites1.txt
grep -v -e "database_proxy_service" ./tmp/requisites1.txt > ./tmp/requisites.txt
python3 -m pip wheel  --wheel-dir=/dist/flowpilot/evaluator-service -r ./tmp/requisites.txt

cd /src/ui
nm install
npm run build
mkdir /dist/flowpilot/ui
mkdir /dist/flowpilot/ui/dist

# Copy the build output to the dist directory
cp -R .next/* /dist/ui/dist
cp -R public /dist/flowpilot/ui/public

# bin
cp -R bin /dist/flowpilot
mkdir /dist/flowpilot/logs
mkdir /dist/flowpilot/tmp

cd /dist
tar cvf flowpilot.tar /flowpilot