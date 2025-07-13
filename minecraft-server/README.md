# Minecraft Server (Docker)

This setup runs both Java and Bedrock Minecraft servers in Docker, along with an optional admin container for scripts and utilities.

---

## What this includes

- `itzg/minecraft-server` for Java Edition
- `itzg/minecraft-bedrock-server` for Bedrock Edition
- A minimal Alpine-based admin container for maintenance tasks
- Volume persistence for world data
- Basic Backup & Management scripts

---

## Setup Instructions

### 1. Copy the environment file

```bash
cp env.template .env
```
Edit `.env` and fill in your desired values (e.g., EULA, MEMORY, DIFFICULTY, etc.).

---

### 2. Create the directory structure
```bash
mkdir -p java/data bedrock/data scripts
```
The scripts folder is optional and used only by the admin container.

---

### 3. Set directory permissions
```bash
# Give full access to the container (which runs as root)
sudo chown -R root:root java/data bedrock/data

# Provide read/execute access to others
sudo chmod -R 755 java/data bedrock/data
```

To confirm which user a container is running as:
```bash
docker exec -it mcj-server id
```

---

### 4. Start the containers
```bash
docker compose up -d
```

### 5. Admin Container
This container can be used to run scripts to for various admin tasks. Example:
```bash
# Backup the Mincraft worlds using mcbackup.sh
docker exec mc-admin-server sh /scripts/mcbackup.sh

```

---

## Project Structure
```plaintext
minecraft-server/
├── docker-compose.yml
├── env.template
├── java/
│   └── data/
├── bedrock/
│   └── data/
├── scripts/              # Optional
└── README.md
```

---

## Notes
- World data is stored in `java/data` and `bedrock/data`, both excluded from version control.
- The admin container does not run a Minecraft server — it's intended for running scripts or inspecting data volumes.
- This project is part of a broader learning process and may evolve or change over time.
