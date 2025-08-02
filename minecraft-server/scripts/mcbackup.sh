#!/bin/bash

# TODO Add a note in log file for [BACKUP]

set -e

# ====== CONFIG ======
BACKUP_DIR="/backups"
LOG_FILE="$BACKUP_DIR/mcbackup.log"
RETENTION_DAYS=7
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# ====== Ensure backup directory exists ======
mkdir -p "$BACKUP_DIR"

# ====== Rotate logs ======
if [ -f "$LOG_FILE" ]; then
    mv "$LOG_FILE" "$LOG_FILE.$TIMESTAMP"
fi
touch "$LOG_FILE"

# ====== Logging helper ======
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

log "=== Starting Minecraft backup job ==="

# ====== Backup Java world ======
if [ -d "/java_world" ]; then
    log "Backing up Java world..."
    tar --exclude='logs' \
        --exclude='maintenance' \
        -czf "$BACKUP_DIR/java_world_$TIMESTAMP.tar.gz" -C /java_world . \
        && log "Java world backup completed."
else
    log "Java world directory not found, skipping."
fi

# ====== Backup Bedrock world ======
if [ -d "/bedrock_world" ]; then
    log "Backing up Bedrock world..."
    tar --exclude='logs' \
        --exclude='maintenance' \
        -czf "$BACKUP_DIR/bedrock_world_$TIMESTAMP.tar.gz" -C /bedrock_world . \
        && log "Bedrock world backup completed."
else
    log "Bedrock world directory not found, skipping."
fi

# ====== Cleanup old backups ======
log "Cleaning up backups older than $RETENTION_DAYS days..."
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;
log "Old backups removed."

log "=== Backup job complete ==="

