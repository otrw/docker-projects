# Minecraft Server

## TODO
- Refactor admin script into `bash` functions for better readability & maintenance.
- Create a dedicated `Dockerfile` for the project.

## What it does
Runs both Java and Bedrock Minecraft servers in Docker, along with a small admin container for scripts and utilities.

## How to use it

### 1. Copy and create the Environment File

```bash
cp env.template .env
```

### 2. Create the required directories
```bash
mkdir -p java/data bedrock/data scripts backups
```
**Note** The `scripts` and `backups` directories are used by the admin container.

## 3. Set directory permissions (if needed)

By default, the Minecraft data directories should come with the correct permissions required. If not, this can be changed using:
```bash
# Give full access to the container (which runs as root)
sudo chown -R root:root java/data bedrock/data

# Provide read/execute access to others
sudo chmod -R 755 java/data bedrock/data

# Check directory permissions
ls -l
docker exec -it <server-name> id
```

### 4. Start the containers
```bash
docker compose up -d
```

## Admin Container

This container starts automatically and includes a simple backup job via `crontab` every 12 hours.

To run a command in the server:

```bash
# Backup Minecraft worlds and clean logs/old backups
docker exec mc-admin-server sh /scripts/mcbackup.sh
```

## Project Structure
```plaintext
minecraft-server/
├── docker-compose.yml
├── env.template
├── java/
│   └── data/
├── bedrock/
│   └── data/
├── scripts/
├── backups/
└── README.md
```

### Includes:
- itzg/minecraft-server (Java Edition)
- itzg/minecraft-bedrock-server (Bedrock Edition)
- Minimal Alpine-based admin container for maintenance
- Persistent volumes for world data
- Basic backup & management scripts

## Notes
- World data is stored in `java/data` and `bedrock/data` (both excluded from version control).
- The admin container does **not** run a Minecraft server — it handles scripts and volume inspection.
- This project is part of a broader learning process and may evolve over time.