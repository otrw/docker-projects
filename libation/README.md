# Libation Docker setup

## About

Audible allows users to download purchased books, and [Libation](https://getlibation.com) is an excellent tool for downloading and managing them in bulk. In addition to the desktop application, Libation is also available as a Docker image.

## Setup

### Account Settings

The Libation Docker image uses a configuration file named `AccountSettings.json`  This file contains the user credentials for connecting to your Audible account and is required.

The simplest way to get a copy of this is to install the Libation application locally first and copy the file.

> **IMPORTANT** This config contains sensitive information. Add to `.gitignore` to avoid being added to version control.

### 1.  Create and prepare local project directories

```bash
# create the project and config directories
mkdir -p ~/docker/libation/config && cd ~/docker/libation

# amend the ownership of the config directory
# Libation image runs as user 1001 and group 1001
sudo chown -R 1001:1001 ./config
```

### 2. Prepare your configuration files

   - Install and run the [Libation desktop app](https://github.com/rmcrackan/Libation/releases).
   - Locate your `AccountSettings.json`. On MacOS, this is typically stored in `$HOME/Libation/`.
   - Copy `AccountSettings.json` to the `config` directory on the docker host.

```bash
# Copy using ssh
scp "$HOME/Libation/AccountSettings.json" <user>@<serverIP>:/home/user/docker/libation/config/
```

### 3. Create `compose.yml`

 ```bash
 # create a docker-compose.yml in the project directory
 touch compose.yml
 ```

Use the following `compose.yml` file.

   ```yaml
   services:
     libation-server:
       container_name: libation-server
       image: rmcrackan/libation:latest
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

> You can use an `.env` file to specify directories for configuration files such as config, db etc. By default, Libation will use the `config` directory.

### 4. Launch the container

  ```bash
docker compose up -d
  ```

### 5. Verify the container is working correctly

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

This section contains basic backup strategy that I use. It may not be suitable for everyone, but I have included it for reference.

STILL TO DO

## RClone Install Script
The latest official install script is:
`sudo -v ; curl https://rclone.org/install.sh | sudo bash`
> The version include with Ubuntu 24.04 is out of date


## Links
- https://getlibation.com/docs/installation/docker
- https://rclone.org/downloads/


