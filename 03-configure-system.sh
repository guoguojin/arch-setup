#!/usr/bin/env bash

cwd=$(dirname "$0")

# set console font for hi-res screen
# You only need this if you've got a 4K resolution on a 15" laptop screen or similar and need bigger fonts for the terminal
# mkdir -p $HOME/code/personal
# git clone https://github.com/powerline/fonts $HOME/code/personal/powerline-fonts
# sudo cp $HOME/code/personal/powerline-fonts/Terminus/PSF/ter-powerline-v32n.psf.gz /usr/share/kbd/consolefonts/ter-powerline-v32n.psf.gz

# Auto-enable bluetooth
sudo sed -i 's|#AutoEnable=false|AutoEnable=true|g' /etc/bluetooth/main.conf

# Disable USB-3 sleep hook to make sure that it doesn't prevent the machine from sleeping
if [[ ! -f /usr/lib/systemd/system-sleep/10-disable-usb.sh ]]; then
    sudo bash -c 'cat <<EOT >> /usr/lib/systemd/system-sleep/10-disable-usb.sh
#!/bin/sh
case $1/$2 in 
	pre/*)
		echo XHC > /proc/acpi/wakeup
		;;
	post/*)
		echo XHC > /proc/acpi/wakeup
		;;
esac
EOT'
fi

sudo chmod a+x /usr/lib/systemd/system-sleep/10-disable-usb.sh
