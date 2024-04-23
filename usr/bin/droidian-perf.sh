#!/bin/bash

mkdir -p /sys/fs/cgroup/schedtune
mount -t cgroup -o schedtune stune /sys/fs/cgroup/schedtune # needs schedtune in kernel

# Configure schedune boosting
# -100 to 100 value, here we boost a little
echo 20 > /sys/fs/cgroup/schedtune/schedtune.boost
# Never use energy-aware task placement for these tasks
echo 1 > /sys/fs/cgroup/schedtune/schedtune.prefer_idle

# Configure Adreno
# Disable bus split
echo 0 > /sys/class/kgsl/kgsl-3d0/bus_split
# Disable software clockgating will be disabled at boot time
echo 0 > /sys/class/kgsl/kgsl-3d0/force_no_nap
# Do not keep bus on when screen is off
echo 0 > /sys/class/kgsl/kgsl-3d0/force_bus_on
# Do not keep clock on when screen is off
echo 0 > /sys/class/kgsl/kgsl-3d0/force_clk_on
# Do not keep regulators on when screen is on
echo 0 > /sys/class/kgsl/kgsl-3d0/force_rail_on

# Configure scheduler
# On fork, give more priority to child than parnet
echo 1 > /proc/sys/kernel/sched_child_runs_first
# Hints to the kernel how much CPU time it should be allowed to use to handle perf sampling events
echo 20 > /proc/sys/kernel/perf_cpu_time_max_percent
# Always allow sched boosting on top-app tasks
echo 0 > /proc/sys/kernel/sched_min_task_util_for_colocation
# 0.68ms default for 20ms window size scaled to 1024
echo 35 > /proc/sys/kernel/sched_min_task_util_for_boost
# By setting timer_migration = 0 in a multi socket machine, the time will stay assigned to a core
echo 0 > /proc/sys/kernel/timer_migration
# Enable scheduler boosting feature
echo 1 > /proc/sys/kernel/sched_boost
# Can't find what this is doing, commit is not useful in kernel source tree :(
echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

# Others
# Disable kernel debug
echo 0 > /sys/kernel/debug/debug_enabled
# Disable vidc fw debug
 echo 0 > /sys/kernel/debug/msm_vidc/fw_debug_mode
# self-tests disabled at runtime
[ -f /sys/module/cryptomgr/parameters/notests ] && echo Y > /sys/module/cryptomgr/parameters/notests
# Do not automatically load TTY Line Disciplines
echo 0 > /proc/sys/dev/tty/ldisc_autoload
# Disable expedited grace periods
echo 1 > /sys/kernel/rcu_normal
# Disable broken IRQ detection
echo 1 > /sys/module/spurious/parameters/noirqdebug
# Disable unnecessary printk logging
echo off > /proc/sys/kernel/printk_devkmsg
# Update /proc/stat less often to reduce jitter
echo 10 > /proc/sys/vm/stat_interval
