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

## Documentation

- [FreshRSS Docs](https://github.com/FreshRSS/FreshRSS/blob/edge/README.md)
- [FreshRSS Docker](https://github.com/FreshRSS/FreshRSS/tree/edge/Docker)
- [Online Demo](https://demo.freshrss.org)
