### Portainer Setup Notes
Portainer CE is included for visual Docker management.

- First-time setup requires visiting the web UI at http://localhost:9000 (or server IP).
- Create the initial admin account manually in the browser.
- This cannot be automated via .env or environment variables.
- After setup, Portainer persists configuration in the ./data volume.

⚠️ Don’t delete or reset the ./data directory unless you want to reconfigure Portainer from scratch.