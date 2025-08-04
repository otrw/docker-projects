
## Scope

As of 2025, I have approximately 175 Audible books. These can be downloaded directly from Audible or by using a great tool called [Libation](https://github.com/rmcrackan/Libation).

Libation also provides an [official Docker image](https://github.com/rmcrackan/Libation/blob/master/Documentation/Docker.md) for running the service in a container.

## Setup

### Account Settings

Libation’s client configuration is stored in two files:

- `AccountSettings.json`
- `Settings.json`

These files are created when you first run the desktop application, usually in the user’s `$HOME` directory.

From the Libation documentation:

> The easiest way to configure these is to run the desktop version of Libation and then copy them into a folder, such as `/opt/libation/config`, that you'll volume mount into the image.

These files contain settings such as:

- User credentials
- Download configuration
- Output formats
- Other application preferences

### Docker Compose Example

```yaml
services:
  libation-server:
    image: rmcrackan/libation:latest
    volumes:
      # Local config files (read-only)
      # Use config files from the Desktop install
      - ./config:/config:ro
      # Named volume for downloaded books
      - libation_books:/books
    restart: unless-stopped

volumes:
  libation_books:
```

### Notes

- The `./config` directory should contain your `AccountSettings.json` and `Settings.json` files from your desktop installation.
- These sensitive files are **not committed to version control**. They are included in `.gitignore` to prevent accidental commits.

---
