#!/bin/bash
# Minecraft Management script used to start common tasks when the minecraft container is running.
# 
# TODO: Add more functionality to this script, such as:
# TODO: Backup Separate worlds
# TODO: Restart Admin server
# TODO: Check for updates
# TODO: Manage plugins/mods
# TODO: Monitor server performance
# TODO: Create variable for the server names so it can to remove hard coded 
# TODO: Client Option. Basic usage removed for now. Add later, check for local install and run client.

PROJDIR="$HOME/projects/docker-projects/minecraft-server"

MCJSERVER="mcj-server" # Java Edition server
MCBSERVER="mcb-server" # Bedrock Edition server
BACKUPDIR="$PROJDIR/scripts/backups"

case "$1" in
  start)
    echo "Starting Minecraft server..."
    docker start mc-server
    ;;
  stop)
    echo "Stopping Minecraft server..."
    docker exec mc-server rcon-cli say Server shutting down in 10 seconds...
    sleep 10
    docker exec mc-server rcon-cli save-all
    sleep 2
    docker stop mc-server
    ;;
  restart)
    echo "Restarting Minecraft server..."
    $0 stop
    sleep 5
    $0 start
    ;;
  backup)
    echo "Running backup..."
    ~/minecraft-backup.sh
    ;;
  status)
    if [ "$(docker inspect -f {{.State.Running}} mc-server 2>/dev/null)" == "true" ]; then
      echo "Minecraft server is running"
      echo "Players online: $(docker exec mc-server rcon-cli list | grep 'There are')"
    else
      echo "Minecraft server is not running"
    fi
    ;;
  console)
    echo "Connecting to server console (type 'exit' to quit)..."
    docker exec -i mc-server rcon-cli
    ;;
esac
```