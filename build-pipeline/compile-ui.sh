#!/bin/bash
# 
# Licensed Materials - Property of IBM
# 5900-AEO
# Copyright IBM Corp.  2025.
# U.S. Government Users Restricted Rights:
# Use, duplication or disclosure restricted by GSA ADP Schedule
# Contract with IBM Corp.
# 



rm -Rf /dist/flowpilot/ui
mkdir /dist/flowpilot/ui

cd /src/ui
npm install
npm run build
mkdir /dist/flowpilot/ui/dist

# Copy the build output to the dist directory
cp -R .next/* /dist/flowpilot/ui/dist
cp -R public /dist/flowpilot/ui/public

