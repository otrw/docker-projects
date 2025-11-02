# Project Scope

As of 2025, I have about 175 Audible books. These can be downloaded directly from Audible or by using a great tool called [Libation](https://github.com/rmcrackan/Libation).

Libation also provides an [official Docker image](https://github.com/rmcrackan/Libation/blob/master/Documentation/Docker.md) for running the service in a container.

## Setup

### Account Settings

Libation’s client configuration is stored in two files:

- `AccountSettings.json`
    - This file contains the user credentials for connecting to your Audible account. This file is required.
- `Settings.json`
    - This file can be skipped and is no longer required.

From the Libation documentation:
> The easiest way to configure these is to run the desktop version of Libation and then copy them into a folder, such as `/opt/libation/config`, that you'll volume mount into the image.

**IMPORTANT** These config files are sensitive and **must not** be committed to version control. They are included in `.gitignore` for safety.

## Quick Start

1. **Create and prepare local project directories**

```bash
# create the project and config directories
mkdir -p libation-docker/config && cd libation-docker

# amend the ownership of the config directory
sudo chown -R 1001:1001 ./config

```

2. **Prepare your configuration files**

   - Install and run the [Libation desktop app](https://github.com/rmcrackan/Libation/releases).
   - Locate your `AccountSettings.json` (usually in your `$HOME/Libation` directory).
   - Copy to the `config` directory on the docker host.

3. **Create `docker-compose.yml`**

 ```bash
 # create a docker-compose.yml in the project directory

 touch libation-docker/docker-compose.yml
 ```


Use the following to create the server

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
**Note** You can also use the `.env` file to specifiy specific directories for confirguration files like the database. By default, if this is not set, Libation will just use the `config` directory. More info can be found [here](https://github.com/rmcrackan/Libation/blob/master/Documentation/Docker.md)

4. **Launch the container**

  ```bash
docker compose up -d
  ```

5. **Verify it’s working**


```bash
# Check the container logs:
docker logs -f libation-server

# Verify files in the container
docker exec -it libation-server ls /data

```

6. **Find your downloads on the host**

The default path for Docker Volumes is: `/var/lib/docker/volumes/`, to find the exact path on the host, use the command:

```bash
# find the exact volume path
docker volume inspect libation_books

# inspect the path using ls
sudo ls /var/lib/docker/volumes/libation_books/_data
```

## Run Without Docker Compose

If you just want to launch Libation quickly without creating a `docker-compose.yml`:

```bash
docker run -d \
  --name libation-server \
  -v $(pwd)/config:/config \
  -v libation_books:/books \
  --restart unless-stopped \
  rmcrackan/libation:latest
```
---

Checks:
- `$(pwd)/config` contains your atleast your `AccountSettings.json`.
- The `config` folder exists in your current directory before running the command.
- File permissions allow container UID `1001` to write to `config`.

