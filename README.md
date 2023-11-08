# Traefik Proxy on Docker on ProxMox

<p align="center">
    <img height="200" alt="Traefik Logo" src="img/logo_traefik.png">
    <img height="200" alt="Docker Logo" src="img/logo_docker.png">
    <img height="200" alt="ProxMox Logo" src="img/logo_proxmox.png">
</p>

Create a [ProxMox](https://www.proxmox.com/en/) LXC container running Ubuntu and install [Traefik Proxy](https://doc.traefik.io/traefik/) on [Docker](https://www.docker.com/).

Tested on ProxMox v7, Docker 20.10 & Traefik 2.10

## Usage

SSH to your ProxMox server as a privileged user and run...

```shell
bash -c "$(wget --no-cache -qLO - https://raw.githubusercontent.com/noofny/proxmox_traefik/master/setup.sh)"
```
