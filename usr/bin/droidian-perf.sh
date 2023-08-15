#!/bin/bash

for ((i=0; i<=7; i++))
do
   echo -6 > /sys/devices/system/cpu/cpu${i}/sched_load_boost
   echo -n "/sys/devices/system/cpu/cpu${i}/sched_load_boost "
   cat /sys/devices/system/cpu/cpu${i}/sched_load_boost
done
