#!/bin/bash
set -e

echo "[INFO] Installing cron jobs..."
crontab /scripts/crontab.txt

echo "[INFO] Starting cron daemon..."
crond -f -l 2

