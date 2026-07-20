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

3. Creating the Admin user.

The `.env` can be configured to create the initial superuser, which provides a username & password.

Alternatively, you can run the command below from the Docker host. You will be prompted to provide a password.

```bash
docker exec -it linkding python manage.py createsuperuser --username=<user> --email=<email>
```

>Optional:  
Create a standard user and log in to your preferred app using this account.

## Networking


## Notes


## Documentation

[linkding Documentation](https://linkding.link/installation/)