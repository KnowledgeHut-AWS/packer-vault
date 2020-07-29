#!/bin/bash
sudo apt update -y && sudo apt install -y curl vim jq git make
curl -Ls get.docker.com | sh
sudo usermod -aG docker ubuntu
sudo docker pull vault
sudo touch /etc/systemd/system/vault.service
sudo chmod a+rw /etc/systemd/system/vault.service

cat << EOF >> /etc/systemd/system/vault.service
[Unit]
Description=Hashicorp Vault service
Requires=docker.service
After=docker.service

[Service]
ExecStart=docker container run --name vault -p 8200:8200 --restart=always -d vault

[Install]
WantedBy=multi-user.target
EOF

sudo chmod a-w /etc/systemd/system/vault.service
sudo systemctl enable vault
sudo systemctl start vault
