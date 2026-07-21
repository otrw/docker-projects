# FreshRSS

## About 

FreshRSS is a self-hosted RSS and Atom feed aggregator.

## Setup

1. Start the container:

```bash
docker compose up -d
```

2. Verify the container is running:

```bash
docker ps
```

3. Browse to <ServerIP:Port> and complete the installation.  

>Optional: 
Create a standard user and log in to your preferred app using this.

## Networking

- Connects to the `npmnet` network to enable Nginx Proxy Manager access.

## Notes

- Also supports `.env` usage.
- No backup configured. Current feed/configuration data is considered non-critical; revisit if usage or stored data increases.
- Some System Settings can only be made by directly editing `config.php`. As FreshRSS data is stored in a named Docker volume (as opposed to a bind mount where files could be edited directly from the host path), the configuration file can be conveniently copied out and then back in.

```bash
# Copy config to edit locally
docker cp freshrss:/var/www/FreshRSS/data/config.php ./config.php
# Copy back after edits
docker cp ./config.php  freshrss:/var/www/FreshRSS/data/config.php
# Restart container to reload config
docker restart freshrss
```

## Documentation

- [FreshRSS Docs](https://github.com/FreshRSS/FreshRSS/blob/edge/README.md)
- [FreshRSS Docker](https://github.com/FreshRSS/FreshRSS/tree/edge/Docker)
- [Online Demo](https://demo.freshrss.org)
