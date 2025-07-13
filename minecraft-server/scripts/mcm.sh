#!/bin/bash
# Minecraft Management script used to start common tasks when the minecraft container is running.
# This script is intended to be run inside a Docker container that manages Minecraft servers.

set -e  # Exit immediately if a command exits with a non-zero status.

# Get the directory of the script
SCRIPTDIR="$(cd "$(dirname "$0")" && pwd)"
PROJECTROOT="$(dirname "$SCRIPTDIR")"
DATE=$(date +%Y%m%d_%H%M%S)

# Assign positional parameters to variables
SERVER=$1
ACTION=$2

BACKUPDIR="$SCRIPTDIR/backups" # Directory where backups will be stored

mkdir -p "$BACKUPDIR" # Create backup directory if it doesn't exist 

MCJSERVER="mcj-server" # Java Edition server
MCBSERVER="mcb-server" # Bedrock Edition server

# Case statement to handle different server types and actions
# Validate the server name argument
case "$SERVER" in
  java)
    CONTAINER="$MCJSERVER"
    SRC="/java_data"
    ;;
  bedrock)
    CONTAINER="$MCBSERVER"
    SRC="/bedrock_data"
    ;;
  *)
    echo "Usage: $0 {java|bedrock} {start|stop|restart|backup|status|logs}"
    exit 1
    ;;
esac

# Validate actions argument
case "$ACTION" in
  start|stop|restart)
    docker "$ACTION" "$CONTAINER"
    ;;
  logs)
    docker logs -f "$CONTAINER"
    ;;
  status)
    docker inspect -f '{{.State.Status}}' "$CONTAINER"
    ;;  
  backup)
    tar -czf "$BACKUPDIR/${SERVER}_world_$DATE.tar.gz" -C "$SRC" .
    echo "[$DATE] Backup complete for $SERVER world. Backup file: $BACKUPDIR/${SERVER}_world_$DATE.tar.gz"
    ;;
  *)
    echo "Usage: $0 {java|bedrock} {start|stop|restart|backup|status|logs}"
    exit 1
    ;;
esac
