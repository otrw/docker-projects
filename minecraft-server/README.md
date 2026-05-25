# Minecraft Bedrock Server (Docker)

This setup runs a Minecraft Bedrock Edition server.

---

## What this includes

- `itzg/minecraft-bedrock-server` for Bedrock Edition
- Persistence for world data
- Basic backup

---

## Setup Instructions

### 1. Copy the environment file

```bash
cp env.template .env
```
Edit `.env` and fill in your desired values

---

### 2. Create the directory structure
```bash
mkdir -p bedrock/data
```

---

### 3. Set directory permissions

```bash
# Give full access to the container (which runs as root)
sudo chown -R root:root bedrock/data

# Optional: If permission issues occur, provide read/execute access to others
sudo chmod -R 755 bedrock/data
```

To confirm which user a container is running as:
```bash
docker exec -it mcb-server id
```

---

### 4. Start the container
```bash
docker compose up -d
```

---

### 5. Backups & Restore

Create a backup of the persistent data directory. 
>Stop the server first for the cleanest backup.

```bash
# Create a backup folder
mkdir -p backups

# Create an archive of the data directory.
tar -czf backups/bedrock-$(date +%F-%H%M).tar.gz bedrock/data
```
This can be run manually or scheduled via cron.

To restore:

```bash
# Replace the date with the appropriate name
tar -xzf backups/bedrock-2026-04-19-1430.tar.gz -C .
```
>Restore will replace any existing data.

---

## Project Structure
```plaintext
minecraft-server/
├── compose.yml
├── env.template
├── bedrock/
│   └── data/
└── README.md
```

---

## Notes
- `VERSION=EX ISTING` added after restart failures caused by upstream version validation against existing world data.
- World data is stored in `bedrock/data`, excluded from version control.
- This project is part of a broader learning process and may evolve or change over time.
    - April 2026 - Removed Java version and admin container.
