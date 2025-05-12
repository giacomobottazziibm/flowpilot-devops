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

rm -Rf /dist/flowpilot/nl2insights_api
rm -Rf /dist/flowpilot/evaluator-service
rm -Rf /dist/flowpilot/db-service

cd /src/text2sql
poetry install
poetry build

WHL_FILES=($(find dist/ -type f -name "*.whl"))
python3 -m pip install  $WHL_FILES

cd /src/api
rm -Rf ./tmp 
rm -Rf ./dist
poetry install
poetry build
WHL_FILES=($(find dist/ -type f -name "*.whl"))
python3 -m pip install dist/api-0.0.2-py3-none-any.whl
mkdir ./tmp
python3 -m pip freeze --all  >./tmp/custom-requisites.txt
#grep -v -e "api" ./tmp/custom-requisites.txt > ./tmp/requisites.txt
python3 -m pip wheel  --wheel-dir=/dist/flowpilot/nl2insights_api -r ./tmp/requisites.txt

cd /src/db
rm -Rf ./tmp 
rm -Rf ./dist
poetry install
poetry build
WHL_FILES=($(find dist/ -type f -name "*.whl"))
python3 -m pip install $WHL_FILES
mkdir ./tmp
python3 -m pip freeze --all  >./tmp/custom-requisites.txt
grep -v -e "evaluator_service" ./tmp/custom-requisites.txt > ./tmp/requisites1.txt
grep -v -e "database_proxy_service" ./tmp/requisites1.txt > ./tmp/requisites.txt
python3 -m pip wheel  --wheel-dir=/dist/flowpilot/db-service -r ./tmp/requisites.txt


cd /src/evaluator
rm -Rf ./tmp 
rm -Rf ./dist
poetry install
poetry build
WHL_FILES=($(find dist/ -type f -name "*.whl"))
python3 -m pip install $WHL_FILES
mkdir ./tmp
python3 -m pip freeze --all  >./tmp/custom-requisites.txt
grep -v -e "evaluator_service" ./tmp/custom-requisites.txt > ./tmp/requisites1.txt
grep -v -e "database_proxy_service" ./tmp/requisites1.txt > ./tmp/requisites.txt
python3 -m pip wheel  --wheel-dir=/dist/flowpilot/evaluator-service -r ./tmp/requisites.txt
