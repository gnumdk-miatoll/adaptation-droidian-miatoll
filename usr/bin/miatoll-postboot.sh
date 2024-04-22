#!/bin/sh

[ -f /etc/miatoll.conf ] && . /etc/miatoll.conf

if [ -z "${LAUNCHED_BY_SYSTEMD}" ]; then
    echo "This script is automatically executed at boot by systemd. Quiting.."
    exit 1
fi

# Enable wlan modem
echo ON > /dev/wlan

# Disable lowmemorykiller
echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo 0 > /sys/module/lowmemorykiller/parameters/enable_lmk

# Set swappiness value to 90. => handled by power_saver kernel module
# echo 90 > /proc/sys/vm/swappiness

# Enable DT2W
[ -z $TOUCHPANEL_DOUBLE_TAP ] && TOUCHPANEL_DOUBLE_TAP=1
echo  $TOUCHPANEL_DOUBLE_TAP > /sys/touchpanel/double_tap
