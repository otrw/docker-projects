#!/bin/sh
# Startup script for the Minecraft admin container

# Fail fast on errors
# This will ensure that if any command fails, the script will exit immediately. 
set -e

# Check if bash is installed
if ! command -v bash >/dev/null 2>&1; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [startup] Bash not found, installing..."
    /sbin/apk add --no-cache bash
fi

# Ensure the cron setup script exists
if [ -x /scripts/set-cron.sh ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [startup] Running cron setup..."
    /scripts/set-cron.sh
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') [startup] Cron setup script not found or not executable."
    exit 1
fi

echo "$(date '+%Y-%m-%d %H:%M:%S') [startup] Setup complete."

# Start cron in the foreground to keep the container running.
echo "$(date '+%Y-%m-%d %H:%M:%S') [startup] Starting cron daemon in foreground..."
crond -f
