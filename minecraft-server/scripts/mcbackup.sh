#!/bin/sh
# Simple backup of both Java and Bedrock worlds
# tar Example:
# tar -czf $HOME/minecraft/scripts/backups/bedrock_world_$DATE.tar.gz -C $HOME/minecraft/bedrock/data .
#
# TODO: Add retention policy to delete old backups
# TODO: Schedule with cron
# TODO: Add log rotation or limit log file size
#
PROJDIR="$HOME/docker-projects/minecraft-server"

DATE=$(date +%Y%m%d_%H%M%S)
BACKUPDIR="$PROJDIR/scripts/backups"
LOGFILE="$BACKUPDIR/backup.log"
BEDROCKDATA="$PROJDIR/bedrock/data"
JAVADATA="$PROJDIR/java/data"

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

