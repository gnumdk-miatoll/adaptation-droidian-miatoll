#!/bin/sh

if [ -z "${LAUNCHED_BY_SYSTEMD}" ]; then
    echo "This script is automatically executed at boot by systemd. Quiting.."
    exit 1
fi

# Enable wlan modem
echo ON > /dev/wlan

# Disable lowmemorykiller
echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo 0 > /sys/module/lowmemorykiller/parameters/enable_lmk

# Set swappiness value to 90
echo 90 > /proc/sys/vm/swappiness

# Enable DT2W
echo 1 > /sys/touchpanel/double_tap
