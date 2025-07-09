# Docker Learning Projects

A public collection of my Docker-based setups built while learning containerization.

This repository contains Docker-based setups I've created and refined while learning containerization, scripting, and modern infrastructure practices. Each project lives in its own folder with its own `docker-compose.yml`, environment config, and usage notes.

⚠️ This repo is intentionally messy — it's a work-in-progress learning space. Mistakes, notes, and reworks are part of the process.

## 📁 Projects

| Project             | Description                                |
|---------------------|--------------------------------------------|
| [`minecraft-server`](./minecraft-server) | Minecraft server with volume persistence |

## 🛠️ Usage

Each subfolder contains a self-contained Docker project. To get started:

1. Pick a folder (e.g. `minecraft-server`)
2. Copy `.env.template` to `.env`:
   ```bash
   cp .env.template .env
   ```
3. Create directory structure outlined in the README.md.
4. Start the container:
   ```bash
   docker compose up -d
   ```
   