#!/bin/bash

mkdir -p /sys/fs/cgroup/schedtune
mount -t cgroup -o schedtune stune /sys/fs/cgroup/schedtune # needs schedtune in kernel

for i in background system-background
do
    mkdir -p /dev/cpuset/$i
    echo 0   > /dev/cpuset/$i/mems
done

for i in top-app foreground camera-daemon
do
    mkdir -p /dev/cpuset/$i
    echo 0   > /dev/cpuset/$i/mems
done
