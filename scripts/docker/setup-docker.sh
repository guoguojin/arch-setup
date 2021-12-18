#!/usr/bin/env bash

sudo usermod -aG docker tanq
sudo bash -c "echo 'kernel.unprivileged_userns_clone=1' > /etc/sysctl.d/unprivileged_userns.conf"
sudo systemctl enable docker.service
