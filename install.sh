#!/bin/bash
set -e  # exit on error
###############################
# Initial Setup Checks
###############################
sudo apt update
if groups $USER | grep -qw 'dialout'; then
    echo "$USER is as member of dialout group"
else
    echo 'Adding $USER to dialout group'
    sudo usermod -a -G dialout $USER
fi
if [ ! -d ~/build ]; then
    echo 'Creating build directory'
    mkdir ~/build -v
fi
sleep 1
bash scripts/debloat.sh
sleep 1
bash scripts/ramdrives.sh
sleep 1
if echo $USER | grep -qw 'kd9yqk'; then
    echo "Custom UDEV for KD9YQK"
    sudo cp udev/* /etc/udev/rules.d/
    sudo udevadm control --reload-rules
    sudo udevadm trigger
fi
#cd scripts
#for f in *.sh; do
#  bash "$f"
#done

echo "Changing to dark mode"
sudo echo "GTK_THEME=Adwaita-dark" >> /etc/environment

echo "Insalling Ham Menu"
sudo apt install extra-xdg-menus -y
echo 'Install Complete :)'
