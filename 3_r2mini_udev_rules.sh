#!/bin/bash
echo ""
echo "This script copies r2mini udev rules to /etc/udev/rules.d/"
echo ""

echo "Mobile connection setting(RS232) : /dev/ttyTHS1 to /dev/ttyMCU :"
if [ -f "/etc/udev/rules.d/98-r2-mini-mcu.rules" ]; then
    echo "98-r2-mini-mcu.rules file already exist."
else 
    echo 'KERNEL=="ttyTHS1", MODE:="0666", GROUP:="dialout", SYMLINK+="ttyMCU"' > /etc/udev/rules.d/98-r2-mini-mcu.rules   
    echo '98-omo-r1-mini-mcu created'
fi

echo ""
echo "YD lidar connection setting(USB) : /dev/ttyUSBx to /dev/ttyLiDAR :"
if [ -f "/etc/udev/rules.d/97-r2-mini-lidar.rules" ]; then
    echo "97-r2-mini-lidar.rules file already exist."
else
    echo 'KERNEL=="ttyUSB*", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", MODE:="0666", GROUP:="dialout",  SYMLINK+="ttyLIDAR"' >/etc/udev/rules.d/97-r2-mini-lidar.rules
    echo '97-r2-mini-lidar.rules created'
fi

systemctl stop nvgetty
systemctl disable nvgetty

echo ""
echo "Reload rules"
echo ""
sudo udevadm control --reload-rules
sudo udevadm trigger
