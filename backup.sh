#! /usr/bin/zsh

source /home/rileymathews/server/mealie/.envrc.secret
echo "stopping container"
cd $DIR
docker compose down

echo "backing up to restic repo"
restic backup ./data 

echo "restarting docker"
docker compose up -d

