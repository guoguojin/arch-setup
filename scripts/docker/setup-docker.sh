#!/usr/bin/env bash

yay -S --noconfirm --needed docker 
yay -S --noconfirm --needed docker-compose 
sudo usermod -aG docker tanq
sudo bash -c "echo 'kernel.unprivileged_userns_clone=1' > /etc/sysctl.d/unprivileged_userns.conf"
sudo systemctl enable docker.service
