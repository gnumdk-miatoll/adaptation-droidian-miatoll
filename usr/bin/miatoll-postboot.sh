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

# Set pulseaudio default settings to prevent crackling (see /etc/security/limits.d/pulse.conf)
sed -i '
s/.*realtime-priority.*/realtime-priority = 5/g
s/.*realtime-scheduling.*/realtime-scheduling = yes/g
s/.*nice-level.*/;nice-level = -11/g
s/.*high-priority.*/;high-priority = yes/g
s/.*avoid-resampling.*/avoid-resampling = true/g
' /etc/pulse/daemon.conf

# Remove me later
rm -f /etc/systemd/system/NetworkManager.service
