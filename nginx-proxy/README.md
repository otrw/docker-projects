# Nginx Proxy Manager

## About 

Nginx Proxy Manager (NPM) provides a web interface for managing reverse proxy hosts and SSL certificates.

## Setup

1. Start the container:

```bash
docker compose up -d
```

2. Verify the container is running:

```bash
docker ps
```

3. Browse to `<ServerIP>:81` for the admin interface. You will be prompted to complete the initial setup and create an account.

## Networking

- Connects to the external `npmnet` Docker network, allowing NPM to proxy other containers connected to the same network.
- Also uses a dedicated `npm_internal` network.

## Notes

- No backup configured. Data is considered non-critical; revisit if usage or stored data increases.

## Documentation

- [NPM Documentation](https://nginxproxymanager.com/guide)
