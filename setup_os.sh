#!/bin/bash


echo "Setup OS : begin"


# locale
echo "Setting locale..."
LOCALE_VALUE="pl_PL.UTF-8"
echo ">>> locale-gen..."
locale-gen ${LOCALE_VALUE}
cat /etc/default/locale
source /etc/default/locale
echo ">>> update-locale..."
update-locale ${LOCALE_VALUE}
echo ">>> hack /etc/ssh/ssh_config..."
sed -e '/SendEnv/ s/^#*/#/' -i /etc/ssh/ssh_config


# timezone
echo "Setting timezone..."
timedatectl set-timezone Europe/Warsaw


# patch
echo "Patching..."
apt update && apt upgrade -y


# packages
echo "Installing packages..."
apt update && apt install -y \
    curl \
    wget \
    htop \
    net-tools


# firewall
echo "Enabling and configuring firewall..."
ufw enable
ufw allow http
ufw allow https
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 8080/tcp
ufw status


# ssh/user
echo "Configuring SSH and user access..."
SSH_USER=proxyadmin
adduser --gecos "" ${SSH_USER}
usermod -aG sudo ${SSH_USER}
ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa_proxy_ssh -q -N ""
cat ~/.ssh/id_rsa_proxy_ssh
mkdir /home/${SSH_USER}/.ssh
cp ~/.ssh/id_rsa_proxy_ssh /home/${SSH_USER}/.ssh/id_rsa_proxy_ssh
cp ~/.ssh/id_rsa_proxy_ssh.pub /home/${SSH_USER}/.ssh/id_rsa_proxy_ssh.pub
cat ~/.ssh/id_rsa_proxy_ssh.pub >> /home/${SSH_USER}/.ssh/authorized_keys
chown -R ${SSH_USER}:${SSH_USER} /home/${SSH_USER}
chmod 600 /home/${SSH_USER}/.ssh/id_rsa*
chmod 600 /home/${SSH_USER}/.ssh/authorized_keys
sed -i -e 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i -e 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart ssh


echo "Setup OS : script complete!"
