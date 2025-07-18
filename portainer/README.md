## Portainer Setup Notes
Portainer CE is included for visual Docker management.

- First-time setup requires visiting the web UI at http://localhost:9000 (or server IP).
- Port 9000 can be remapped in the `docker-compose.yml`
- Create the initial Portainer admin account manually in the browser.
    - This cannot be automated via `.env` or environment variables in the CE edition.
    - Use a strong password for the Admin user.
- After setup, Portainer persists configuration in the `./data` directory.
- Container updates can be run manually with: `docker pull portainer/portainer-ce && docker compose up -d`

---

> ⚠️ Don’t delete or reset the `./data` directory unless you want to reconfigure Portainer from scratch.

> ⚠️ Make sure Portainer is not publicly exposed without authentication or firewall rules.
