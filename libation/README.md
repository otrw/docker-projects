# Libation Docker setup

## About

Audible allows users to download purchased books, and [Libation](https://getlibation.com) is an excellent tool for downloading and managing them in bulk. In addition to the desktop application, Libation is also available as a Docker image.

### Quick Start

```bash
git clone https://github.com/otrw/docker-projects.git
cd docker-projects/libation
docker compose up -d
docker logs -f libation-server
```

## Setup

### Account Settings

The Libation Docker image uses a configuration file named `AccountSettings.json`  This file contains the user credentials for connecting to your Audible account and is required for Libation to authenticate.

The simplest way to get a copy of this is to install the Libation application locally first and copy the file.

> **IMPORTANT** This config contains sensitive information. Add to `.gitignore` to avoid being added to version control.

### 1. Create and prepare local project directories

```bash
# create the project, config and backup directories
mkdir -p ~/docker/libation/config backup && cd ~/docker/libation
```

### 2. Prepare your configuration files

   - Install and run the [Libation desktop app](https://github.com/rmcrackan/Libation/releases).
   - Locate your `AccountSettings.json`. On macOS, this is typically stored in `$HOME/Libation/`.
   - Copy `AccountSettings.json` to the `config` directory on the Docker host.

```bash
# Copy using ssh
scp "$HOME/Libation/AccountSettings.json" <user>@<serverIP>:/home/user/docker/libation/config/
```

### 3. Amend the file and directories permissions

The docker image runs as user 1001 and group 1001, so the `config` directory must be owned by these IDs on the server.

```bash
cd ~/docker/libation

# Amend User and Group permissions
sudo chown -R 1001:1001 ./config
```

### 4. Create a `compose.yml`

 ```bash
 # create a compose.yml in the project directory
 vim compose.yml
 ```

Use the following for the `compose.yml` file.

   ```yaml
   services:
     libation-server:
       container_name: libation-server
       image: rmcrackan/libation:13.4.1
       volumes:
         # Local configuration files
         - ./config:/config
         # Named volume for downloaded books
         - libation_books:/data
       restart: unless-stopped

   volumes:
     libation_books:
       name: libation_books
   ```

> You can use an `.env` file to specify directories for configuration files such as config, db etc. By default, Libation will use the `config` directory. An example `.env` file has been provided.

### 5. Launch the container

  ```bash
docker compose up -d
  ```

### 6. Verify the container is working correctly

```bash
# View the container logs:
docker logs -f libation-server

# Verify downloaded files in the container
docker exec -it libation-server ls /data

# Inspect docker volume
docker volume inspect libation_books

# Inspect docker volume using `ls`
sudo ls /var/lib/docker/volumes/libation_books/_data
```
### Additional checks
- The `config` directory exists in your current directory before running the command.
- `$(pwd)/config` contains at least your `AccountSettings.json`.
- File permissions allow container user and group `1001` to write to `config`.

## Backup

This section describes the basic backup strategy that I use. It may not be suitable for everyone, but I have included it for reference.

The downloaded books are stored in the `libation_books` Docker volume, while `AccountSettings.json` is stored in the local `config` directory.

To back these up, I use a small helper container to:
- Create a compressed archive of the config directory
- Sync the contents of the `libation_books` volume to the backup directory using `rsync`

### Steps

Create a `backup-compose.yml` file for the helper container using:

```yaml
services:
  libation-backup:
    image: alpine
    volumes:
      # Mount the books volume as read-only and the backup directory for storing the backup tar files
      - libation_books:/books:ro
      - ${BACKUP_DIR}:/backup # Mount local backup directory for storing backups
      - ./config:/config:ro # Mount local config for backup
    command:
      - sh
      - -c
      - >
        apk add --no-cache rsync &&
        mkdir -p /backup/config /backup/books && 
        tar czf /backup/config/lib-config-$(date +%F-%H%M%S).tar.gz -C /config . &&
        rsync -avh --delete /books/ /backup/books/

volumes:
  libation_books:
    external: true
```
> Local backups can optionally be copied to external storage or cloud storage using tools such as [rclone](https://rclone.org)

### Usage

Using `.env`
```bash
# Copy env.template to .env
cp env.template .env

# set BACKUP_DIR to the desired backup location
vim .env
```

Run a Backup

```bash
# Run container
docker compose -f backup-compose.yml up
```

Restore a Backup

```bash
# Extract config archive
tar xzf lib-config-YYYY-MM-DD-HHMMSS.tar.gz -C ./config

# Restore downloaded books to the Docker volume
sudo rsync -avh /path/to/backup/books/ /var/lib/docker/volumes/libation_books/_data/
```

## Project Structure

```text
libation/
├── README.md
├── backup/
├── backup-compose.yml
├── compose.yml
├── config/
└── env.template
```

## Links
- [Libation](https://getlibation.com/)
- [Libation Docker Support](https://getlibation.com/docs/installation/docker)
