#!/bin/bash

mkdir -p /sys/fs/cgroup/schedtune
mount -t cgroup -o schedtune stune /sys/fs/cgroup/schedtune # needs schedtune in kernel
