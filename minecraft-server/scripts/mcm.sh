#!/bin/bash
#
# Minecraft Management script used to start common tasks when the minecraft container is running.
# More of a lesson in bash scripting.
# TODO: Add more functionality to this script, such as:
# - Backup worlds
# - Check for updates
# - Manage plugins/mods
# - Monitor server performance
# - Create variable for the server name so it can to remove hard coded 
# - Remove client option.

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
  client)
    # Default path - edit this if your launcher is elsewhere
  MC_LAUNCHER_PATH=${MC_LAUNCHER_PATH:-"$HOME/projects/minecraft-server/minecraft-launcher/minecraft-launcher"}
  if [ -f "$MC_LAUNCHER_PATH" ]; then
    echo "Starting Minecraft Launcher"
    exec "$MC_LAUNCHER_PATH" &
  else
    echo "Error: Minecraft Launcher not found at $MC_LAUNCHER_PATH"
    echo "Please check the path or set the correct path with: export MC_LAUNCHER_PATH=/path/to/launcher"
  fi
  ;;
  *)
    echo "Usage: $0 {start|stop|restart|backup|status|console|client}"
    exit 1
    ;;
esac
```