# Portainer

## What it does
Portainer is a browser-based Docker management interface.  
It provides visual tools to manage containers, images, networks, and volumes — useful for understanding and controlling your Docker environment from any device on your network.

## How to use it
1. Start the service with:
```bash
docker compose up -d
```
2. Open you browser and go to: http://your-server-ip:9000
3. Create the inital admin account using a **strong password**.

## NOTES
- The Community Edition does not support .env files for configuration.
- A local ./data directory is bind-mounted for persistence. If deleted, Portainer will reset and require re-setup.
- Do not expose Portainer publicly without authentication and/or firewall rules.

## References
- [Portainer Website](https://www.portainer.io)
- [Portainer CE on Docker Hub](https://hub.docker.com/r/portainer/portainer-ce)
