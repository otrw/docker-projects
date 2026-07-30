# Audio Bookshelf

## About

Audio Bookshelf is a self hosted audiobook and podcast server.

## Setup

1. Start the container:

```bash
docker compose up -d
```

2. Verify the container is running:

```bash
docker ps
```

3. Browse to the configured hostname in Nginx Proxy Manager and complete the initial setup.

> **Note:**
> This deployment is intended to be accessed through Nginx Proxy Manager. No host port is published in `compose.yml`.

### Optional

Create a standard user account and use the administrator account to manage and share the library.

## Networking

- Connected to the external `npmnet` Docker network.
- Intended to be accessed through Nginx Proxy Manager.
- WebSocket support must be enabled in the proxy host.

## Notes

- No backup is configured for the Audiobookshelf configuration or metadata.
- Audiobook content is read directly from the `libation_books` Docker volume and is managed by the Libation project.

## Documentation

- [Official documentation](https://audiobookshelf.org/docs/documentation/introduction/)
- [GitHub](https://github.com/advplyr/audiobookshelf)
