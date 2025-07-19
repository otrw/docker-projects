# Docker Learning Projects

This is a public collection of Docker-based setups I've created while learning containerization, scripting, and infrastructure practices.

> ⚠️  This repo is intentionally messy — it's a work-in-progress learning space. Expect rough edges, broken things, and occasional good ideas.

### About This Repo

This monorepo exists as part of my effort to “learn in public” while pivoting from Windows sysadmin work into modern cloud-native tooling. Mistakes, false starts, and rework are all part of the journey.

If you find something useful here — great! If not, I'm still learning anyway 🤓



---

## Projects

| Project | Description |
|---------|-------------|
| [`minecraft-server`](./minecraft-server) | A Minecraft server stack using Docker with volume persistence and environment config support |
| [`portainer`](./portainer) | A simple portainer server available at port 9000 |
| [`whoami`](./whoami) | Shows basic request info to confirm routing behaviour. A refresher project to help muscle memory with `docker-compose.yml` |
| [`dozzle`](./dozzle) | Web-based viewer for container logs. Another refresher project to help muscle memory with `docker-compose.yml` |
| [`hedgedoc`](./hedgedoc) | Markdown editor for the browser. Introduction to using databases as additional services |

More to come as I build and learn.

---

## How to Use

Each subfolder contains a self-contained Docker project with a `README.md`

For example, to get started with the `minecraft-server`:

1. **Copy the environment template**:
   ```bash
   cp env.template .env
   ```
2. **Create any required directory structure** 
   ```bash
   mkdir -p data/ config/
   ```
4. **Start the container**:
   ```bash
   docker compose up -d
   ```
