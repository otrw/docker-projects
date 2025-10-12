#!/usr/bin/env bash

# Script to create dir structure and correct permissions to run Libation.
# Must be run with sudo.

# Stop on any error
set -e

# Create host dirs with correct ownership
mkdir -p ./config ./db

# This file must be provided as it contains Audible login information
mv ./AccountsSettings.json ./config

chown -R 1001:1001 ./config ./db



