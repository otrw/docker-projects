#!/bin/sh
# mcbackup.sh
# Simple backup of both Java and Bedrock worlds
#

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

# Maintenance: Clean up old backups
# Retention policy: Keep the latest 7 backups for each world
echo "[$DATE] Cleaning up old backups..." | tee -a "$LOGFILE"
# Find and delete backups older than the latest 7 for each world
#Java world
find "$BACKUPDIR" -name "java_world_*.tar.gz" -type f | sort -r | tail -n +8 | xargs -r rm --
# Bedrock world
find "$BACKUPDIR" -name "bedrock_world_*.tar.gz" -type f | sort -r | tail -n +8 | xargs -r rm --
echo "[$DATE] Old backups cleaned up. Retention policy applied." | tee -a "$LOGFILE"

# Maintenance: Simple log rotation for backup.log
# Limit log file size to 10MB, rotate if necessary
MAX_SIZE=10485760  # 10 MB (10 × 1024 × 1024)

if [ -f "$LOGFILE" ] && [ $(stat -c%s "$LOGFILE") -gt $MAX_SIZE ]; then
    mv "$LOGFILE" "$LOGFILE.old"
    touch "$LOGFILE"
    echo "[$DATE] Log rotated (old saved as backup.log.old)" > "$LOGFILE"
fi
