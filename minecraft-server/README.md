# Minecraft Bedrock Server (Docker)

This setup runs a Minecraft Bedrock Edition server.

## What this includes

- `itzg/minecraft-bedrock-server` for Bedrock Edition
- Persistent Docker volume for world data
- Basic backup and Restore

## Setup Instructions

### 1. Copy the environment file

```bash
cp env.template .env
```

### 2. Edit `.env`

Set any desired environment variables. `EULA=true` is mandatory.

### 3. Start the container

```bash
docker compose up -d
```

### 4. Backup & Restore

Create a compressed backup of the Bedrock Docker volume.
>Note: Stop the server first for the cleanest backup.

```bash
# Create a backup directory
mkdir -p backup

# Run the backup compose file
docker compose -f backup-compose.yml run --rm minecraft-backup

# Verify backup was created
ls backup/

# Restore backup data to the Docker volume
# Docker named volumes are stored under `/var/lib/docker/volumes/` by default.
sudo tar xzf backup/bedrock-2026-05-26-045629.tar.gz -C /var/lib/docker/volumes/mc-bedrock-data/_data/
```
> Warning: Restoring a backup will overwrite any existing world data in the volume.

## Project Structure
```plaintext
minecraft-server/
├── backup-compose.yml
├── compose.yml
├── env.template
└── README.md
```

## Notes
- This project is part of a broader learning process and may evolve or change over time.
    - April 2026 - Removed Java version and admin container.
- Optional additional environment variable `VERSION=EXISTING`.
    - Prevents automatic upgrades and reuses the existing Bedrock server version already present in `/data`. 
    - Do not use on first startup or with an empty data directory.
    - Used as a workaround to solve a `Server 500 Error` loop after a container restart.