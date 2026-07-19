# Portainer CE

A lightweight web interface for managing Docker environments such as hosts, containers, images, volumes, networks and stacks to be administered from a browser.

## Purpose

This deployment is used as a secondary management interface for my Docker host.

It is primarily used to:

- View running containers and logs
- Inspect volumes and networks
- Perform quick administrative tasks without using the CLI

> Docker Compose remains the primary tool for deployments where possible.

## Setup

Start the container:

```bash
docker compose up -d
```

Verify the container is running:

```bash
docker ps
```

Access the web interface and complete the initial administrator setup.

## Networking

- Connected to the `npmnet` Docker network.
- Intended access via Nginx Proxy Manager.

## Notes

- Currently a convenience tool.
- Compose files should remain under version control.
- Using `lts` image label.
- Backup not required.

## Documentation

- [Official Portainer Docs](https://docs.portainer.io/start/install-ce)
