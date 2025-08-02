#!/bin/bash

# Restores Minecraft worlds.
# Runs from the host, not from the admin container interactively
# TODO Refine how it handles file names, currently expects you to know the filename of the file restored.
# TODO Add [RESTORE] label in the log file.

set -e

BACKUP_DIR="./backups"
LOG_FILE="$BACKUP_DIR/mcbackup.log"

# ====== Usage ======
if [ $# -lt 2 ]; then
    echo "Usage: $0 <java|bedrock> <backup_file.tar.gz>"
    echo "Example: $0 java java_world_2025-08-02_07-50-08.tar.gz"
    exit 1
fi

WORLD_TYPE="$1"
BACKUP_FILE="$2"

# ====== Validate backup file ======
if [ ! -f "$BACKUP_DIR/$BACKUP_FILE" ]; then
    echo "Backup file not found: $BACKUP_DIR/$BACKUP_FILE"
    exit 1
fi

# ====== Set world volume name ======
case "$WORLD_TYPE" in
    java)
        VOLUME_NAME="minecraft-server_java_world"
        CONTAINER_NAME="mc-java"
        ;;
    bedrock)
        VOLUME_NAME="minecraft-server_bedrock_world"
        CONTAINER_NAME="mc-bedrock"
        ;;
    *)
        echo "Invalid world type: $WORLD_TYPE (use 'java' or 'bedrock')"
        exit 1
        ;;
esac

# ====== Logging helper ======
log() {
    local msg="[$(date '+%Y-%m-%d %H:%M:%S')] $*"
    echo "$msg"
    echo "$msg" >> "$LOG_FILE"
}

# ====== Confirm destructive action ======
echo "This will DELETE the current $WORLD_TYPE world and replace it with $BACKUP_FILE"
read -p "Type YES to confirm: " CONFIRM
if [ "$CONFIRM" != "YES" ]; then
    echo "Restore cancelled."
    exit 1
fi

log "=== Starting restore for $WORLD_TYPE world from $BACKUP_FILE ==="

# ====== Run restore in a temp container ======
docker run --rm \
    -v ${VOLUME_NAME}:/${WORLD_TYPE}_world \
    -v "$(pwd)/backups":/backups \
    alpine:latest \
    sh -c "rm -rf /${WORLD_TYPE}_world/* && \
           tar -xzf /backups/$BACKUP_FILE -C /${WORLD_TYPE}_world"

log "Restore completed for $WORLD_TYPE world"

# ====== Restart the Minecraft container ======
docker restart $CONTAINER_NAME >/dev/null
log "Container $CONTAINER_NAME restarted"

log "=== Restore process complete for $WORLD_TYPE world ==="

