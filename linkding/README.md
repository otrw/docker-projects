# linkding

## About 

Minimal self-hosted bookmark manager.

## Setup

1. Start the container:

```bash
docker compose up -d
```

2. Verify the container is running:

```bash
docker ps
```

3. Creating the admin user.

The `.env` can be configured to create the initial superuser, which provides a username & password.

>Ensure the `.env` is excluded from version control.

>Optional:  
Create a standard user and log in to your preferred app using this account.

## Networking

- Connects to the npmnet network, allowing Nginx Proxy Manager to access the service without publishing a host port.

## Notes

- Alternative superuser setup: Run the command below from the Docker host to create the superuser account. You will be prompted to provide a password.
- This method is mandatory if planning to use OIDC for SSO, as an email address is used as the identity instead of the username.

```bash
docker exec -it linkding python manage.py createsuperuser --username=<user> --email=<email>
```

- Some System Settings can only be made by directly editing `config.php`. As FreshRSS data is stored in a named Docker volume, the configuration file can be conveniently copied out and then back in.

```bash
# Copy config to edit locally
docker cp freshrss:/var/www/FreshRSS/data/config.php ./config.php
# Copy back after edits
docker cp ./config.php  freshrss:/var/www/FreshRSS/data/config.php
# Restart container to reload config
docker restart freshrss
```

## Documentation

[linkding Documentation](https://linkding.link/installation/)  
[Enable OIDC](https://linkding.link/options/#ld_enable_oidc)