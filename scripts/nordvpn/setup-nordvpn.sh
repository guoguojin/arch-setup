#!/usr/bin/env bash

yay -S --noconfirm --needed nordvpn
sudo systemctl enable --now nordvpnd
sudo gpasswd -a $(whoami) nordvpn