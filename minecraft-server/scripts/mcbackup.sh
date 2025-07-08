#!/bin/sh
# Simple backup of both Java and Bedrock worlds
DATE=$(date +%Y%m%d_%H%M%S)
mkdir -p ../backups

tar -czf $HOME/minecraft/scripts/backups/java_world_$DATE.tar.gz -C $HOME/minecraft/java/data .
tar -czf $HOME/minecraft/scripts/backups/bedrock_world_$DATE.tar.gz -C $HOME/minecraft/bedrock/data .
