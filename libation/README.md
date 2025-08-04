## Scope

As of 2025, I have about 175 Audible books. These can be downloaded directly from Audible or by using a great tool called [Libation](https://github.com/rmcrackan/Libation).

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

These config files are sensitive and **must not** be committed to version control. They are included in `.gitignore` for safety.


## Quick Start

1. **Prepare your configuration files**

   - Install and run the [Libation desktop app](https://github.com/rmcrackan/Libation/releases).
   - Locate your `AccountSettings.json` and `Settings.json` (usually in your `$HOME` directory).
   - Copy them into a local folder named `config` alongside your `docker-compose.yml`.

2. **Create `docker-compose.yml`**
   Save the following in the same directory as your `config` folder:

   ```yaml
   services:
     libation-server:
       container_name: libation-server
       image: rmcrackan/libation:latest
       volumes:
         # Local config files (currently writable - amend to RO later)
         - ./config:/config
         # Named volume for downloaded books
         - libation_books:/books
       restart: unless-stopped

   volumes:
     libation_books:
       name: libation_books
   ```

3. **Launch the container**

   ```bash
   docker compose up -d
   ```

4. **Verify it’s working**

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

5. **Find your downloads on the host**

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
- `$(pwd)/config` contains your `AccountSettings.json` and `Settings.json`.
- The `config` folder exists in your current directory before running the command.
- File permissions allow container UID `1001` to write:
  ```bash
  sudo chown -R 1001:1001 ./config
  ```

---

**TODO**
- Replace `Settings.json` with the **LIBATION_BOOKS_DIR** environment variable.
- Add a database directory mapping.
- Add a database environemt variable.
- Re-enable `:ro` for the config once all runtimes writes have been relocated