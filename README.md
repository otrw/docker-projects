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

More to come as I build and learn.

---

## How to Use

Each subfolder contains a self-contained Docker project. To get started:

1. **Pick a folder** (e.g. `minecraft-server`)
2. **Copy the environment template**:
   ```bash
   cp env.template .env
   ```
3. **Create any required directory structure** (check projects `README.md`)
4. **Start the container**:
   ```bash
   docker compose up -d
   ```
