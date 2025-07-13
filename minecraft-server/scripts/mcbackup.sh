#!/bin/sh
# mcbackup.sh
# Simple backup of both Java and Bedrock worlds
#
# TODO: Add retention policy to delete old backups
# TODO: Schedule with cron
# TODO: Add log rotation or limit log file size

DATE=$(date +%Y%m%d_%H%M%S)
SCRIPTDIR=$(dirname "$0")
BACKUPDIR="$SCRIPTDIR/backups"

# Assumes the conatainer mounts volumes:
# - /scripts
# - /bedrock/data
# - /java/data

LOGFILE="$BACKUPDIR/backup.log"

BEDROCKDATA="/bedrock_data"
JAVADATA="/java_data"

# Create backup directory if it doesn't exist
if [ ! -d "$BACKUPDIR" ]; then
    mkdir -p "$BACKUPDIR"
else
    echo "Backup directory already exists: $BACKUPDIR"
fi

# Backup both worlds

# Java world
if ! tar -czf "$BACKUPDIR/java_world_$DATE.tar.gz" -C "$JAVADATA" . ; then
    echo "[$DATE] Failed to backup Java world." | tee -a "$LOGFILE"
    exit 1
else
    echo "[$DATE] Backed up Java world to $BACKUPDIR/java_world_$DATE.tar.gz" | tee -a "$LOGFILE"
fi

# Bedrock world
if ! tar -czf "$BACKUPDIR/bedrock_world_$DATE.tar.gz" -C "$BEDROCKDATA" . ; then
    echo "[$DATE] Failed to backup Bedrock world." | tee -a "$LOGFILE"
    exit 1
else
    echo "[$DATE] Backed up Bedrock world to $BACKUPDIR/bedrock_world_$DATE.tar.gz" | tee -a "$LOGFILE"
fi

echo "[$DATE] Backup Jobs Complete. See [$LOGFILE] for details."

