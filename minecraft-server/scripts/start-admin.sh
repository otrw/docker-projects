#!/bin/sh
# Startup script for the Minecraft admin container

# Fail fast on errors
# This will ensure that if any command fails, the script will exit immediately. 
set -e

# Installing necessary packages.
# TODO: Look at using a DOCKERFILE to install these packages instead of doing it at runtime.
# TODO: Colour output for better visibility


# Check if bash is installed
if ! command -v bash >/dev/null 2>&1; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [startup] Bash not found, installing..."
    /sbin/apk add --no-cache bash
fi
# Check if docker-cli is installed
if ! command -v docker >/dev/null 2>&1; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') [startup] Docker CLI not found, installing..."
    /sbin/apk add --no-cache docker-cli
fi

# Ensure the mcm management script is available globally
if [ -f /scripts/mcm.sh ]; then
    ln -sf /scripts/mcm.sh /usr/local/bin/mcm
    chmod +x /usr/local/bin/mcm
    echo "$(date '+%Y-%m-%d %H:%M:%S') [startup] Linked mcm to /usr/local/bin/mcm"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') [startup] mcm.sh not found at /scripts/mcm.sh"
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
