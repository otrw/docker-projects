**Work In Progress** 

**TODO**
 - Amend README layout
 - Confirm `Settings.json` options to change download descriptions  
 **NOTE**: This is a personal setting mainly to define the naming convention and format of downloaded books snd series.
- Add backup script to move content from Docker volume to external server disk.


---

# Project Scope

As of 2025, I have about 175 Audible books. These can be downloaded directly from Audible or by using a great tool called [Libation](https://github.com/rmcrackan/Libation).

Libation also provides an [official Docker image](https://github.com/rmcrackan/Libation/blob/master/Documentation/Docker.md) for running the service in a container.

## Setup

### Account Settings

Libation’s client configuration is stored in two files:

- `AccountSettings.json`
    - This file contains the user credentials for connecting to your Audible account. This file is required.
- `Settings.json`
    - This files contains application preferences and settings i.e. download options, output format etc. This file is optional and not required.

These files are created when you first run the desktop application, usually in the user’s `$HOME` directory.

From the Libation documentation:
> The easiest way to configure these is to run the desktop version of Libation and then copy them into a folder, such as `/opt/libation/config`, that you'll volume mount into the image.

**IMPORTANT** These config files are sensitive and **must not** be committed to version control. They are included in `.gitignore` for safety.

## Quick Start

1. **Create you local project directories**

```bash
mkdir -p libation-docker/config
```

2. **Prepare your configuration files**

   - Install and run the [Libation desktop app](https://github.com/rmcrackan/Libation/releases).
   - Locate your `AccountSettings.json` (usually in your `$HOME` directory).
   - Copy them into the local directory `config`.

3. **Create `docker-compose.yml`**
  Create the following and save to `/libation-docker/docker-compose.yml`

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
**Note** You can also use the `.env` file to specifiy specific directories for confirguration files like the database. By default, if this is not set, Libation will just use the `config` directory.

4. **Launch the container**

   ```bash
   cd libation-docker/ && docker compose up -d
   ```

5. **Verify it’s working**

   - Check the container logs:

     ```bash
     docker logs -f libation-server
     ```

     You should see it scanning your library and processing downloads.
   - Once a download completes, list files inside the container:

     ```bash
     docker exec -it libation-server ls /books
     ```

     If you see audiobook files (`.m4b`), Libation is working correctly.

6. **Find your downloads on the host**

   - Files are stored in the `libation_books` named volume.
   - To find the path on your host:

     ```bash
     docker volume inspect libation_books
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

Check:
- `$(pwd)/config` contains your atleast your `AccountSettings.json`.
- The `config` folder exists in your current directory before running the command.
- File permissions allow container UID `1001` to write:
  ```bash
  sudo chown -R 1001:1001 ./config
