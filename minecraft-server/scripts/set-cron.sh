#!/bin/sh
set -e

# Set the crontab explicitly for this container
crontab /scripts/crontab.txt

# Show active crontab
echo "Installed cron jobs:"
crontab -l
