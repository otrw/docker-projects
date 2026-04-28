#!/bin/bash

# This script is used to backup the config and data of the libation app.
# Set to run once a month using cron.
# Run from the server where the app is running.

docker compose -f /path/to/compose.yml --abort-on-container-exit
rclone copy /path/to/backup <RemoteName>:<RemoteDirectory> --log-file=/path/to/logfile.log --log-level INFO