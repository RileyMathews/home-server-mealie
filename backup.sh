#! /usr/bin/zsh


on_error() {
    curl -d "Mealie backup failed" https://ntfy.rileymathews.com/home-server-alerts
}

set -e
trap 'on_error' ERR 

source /home/rileymathews/server/mealie/.envrc.secret
echo "stopping container"
cd $DIR
docker compose down

echo "backing up to restic repo"
restic backup ./data 

echo "restarting docker"
docker compose up -d

curl -d "Mealie backup finished" https://ntfy.rileymathews.com/home-server-alerts
