# Minecraft Server (Docker)

  

## ✅ What this does

- Runs a Minecraft server in Docker.

- Stores world data in `data/` (gitignored).


## 🛠️ Setup

1. Copy `.env.template` to `.env` and fill in values.

```bash

cp .env.template .env

```

2. Create the local `data/` folders for the Minecraft Editions, these will map to the containers.

```bash

mkdir -p java/data/ bedrock/data admin/

```

>[!NOTE]
The admin directory is optional, this will map to the scripts folder containing any admin scripts and utilities.

# Update permissions for the data directories

```bash

# RWX for the container

sudo chown -R root:root java/data/ bedrock/data/

# RX for other users

sudo chmod -R 755 java/data/ bedrock/data/

```

>[!TIP]To Check user the container is running as:
>```bash
>docker exec -it container_name id
>```


