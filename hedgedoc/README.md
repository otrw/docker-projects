# HedgeDoc

## What it does
Browser-based collaborative Markdown editor. Feels like “Obsidian Lite” with live sync. I currently use this in the single guest mode only and have not attempted to set any users. Often used as a simple scratch pad.

## How to use it
1. Create the `.env` file from the provided template:
```bash
cp env.template .env
```
2. Edit `.env` to configure your instance.
3. Start the service with:
```bash
docker compose up -d
```
4. Open you browser and go to: http://your-server-ip:3000
5. Click "New Guest Note" to start writing.

## References
- [HedgeDoc Website](https://hedgedoc.org/releases/)
- [HedgeDoc Github](https://github.com/hedgedoc)
