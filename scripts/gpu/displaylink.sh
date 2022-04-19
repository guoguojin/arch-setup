#!/usr/bin/env bash

yay -S --noconfirm --needed displaylink evdi

systemctl enable displaylink.service

if [[ ! -f /usr/share/X11/xorg.conf.d/20-evdidevice.conf ]]; then
    sudo bash -c 'cat <<EOT >> /usr/share/X11/xorg.conf.d/20-evdidevice.conf
Section "OutputClass"
  Identifier "DisplayLink"
  MatchDriver "evdi"
  Driver "modesetting"
  Option  "AccelMethod" "none"
EndSection
EOT'
fi

# This is to disable pageflip for the bug that causes screens to freeze with the displaylink driver
# but disabled for now as it causes other issues with screen virtual size
if [[ ! -f /usr/share/X11/xorg.conf.d/20-displaylink.conf ]]; then
    sudo bash -c 'cat <<EOT > /usr/share/X11/xorg.conf.d/20-displaylink.conf
Section "Device"
  Identifier "DisplayLink"
  Driver "modesetting"
  Option "PageFlip" "false"
EndSection 
EOT'
fi

