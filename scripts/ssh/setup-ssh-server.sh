#!/usr/bin/env bash
yay -S --noconfirm --needed openssh
sudo systemctl enable sshd.service 
sudo systemctl start sshd.service 
