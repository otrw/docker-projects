# Docker Learning Projects

## About This Repo

This is a public collection of Docker-based setups I've created while learning containerisation, scripting, and infrastructure practices.

> ⚠️  This repo is intentionally messy — it's a work-in-progress learning space. Expect rough edges, broken things, and occasional good ideas.

## Projects

| Project | Description |
|---------|-------------|
| [`minecraft-server`](./minecraft-server) | WIP. A Minecraft server stack using Docker with volume persistence and environment config support |
| [`portainer`](./portainer) | A simple portainer server available at port 9000 |
| [`whoami`](./whoami) | Shows basic request info to confirm routing behaviour. A refresher project to help muscle memory with `docker-compose.yml` |
| [`dozzle`](./dozzle) | Web-based viewer for container logs. Another refresher project to help muscle memory with `docker-compose.yml` |
| [`hedgedoc`](./hedgedoc) | Markdown editor for the browser. Introduction to using databases as additional services |
| [`libation`](./libation) | WIP. Backup tool for your Audible library |

Updated as I build / learn.

---

## How to Use

Each subfolder contains a self-contained Docker project with a `README.md`

For example, to get started with the `whoami`:

1. Run with:
```bash
 docker compose up -d
```
2. Open you browser and visit: http://your-server-ip:2001
