#!/bin/bash


# locale
echo "Setting locale..."
LOCALE_VALUE="en_AU.UTF-8"
echo ">>> locale-gen..."
locale-gen ${LOCALE_VALUE}
cat /etc/default/locale
source /etc/default/locale
echo ">>> update-locale..."
update-locale ${LOCALE_VALUE}
echo ">>> hack /etc/ssh/ssh_config..."
sed -e '/SendEnv/ s/^#*/#/' -i /etc/ssh/ssh_config


echo "Creating folders..."
mkdir -p /home/traefik/data
mkdir -p /home/traefik/letsencrypt
cd /home/traefik
mv /docker-compose.yaml /home/traefik/docker-compose.yaml
mv /traefik.yaml /home/traefik/traefik.yaml


echo "Creating stack..."
docker-compose up --no-start
echo "Starting stack..."
docker-compose up --detach


echo "Setup Traefik complete - you can access the console at http://$(hostname -I):8080/"
