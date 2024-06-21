#!/bin/bash

mkdir -p /dev/cpuset
mount none /dev/cpuset -t cpuset -o nodev,noexec,nosuid

for i in background system-background top-app foreground camera-daemon
do
    mkdir -p /dev/cpuset/$i
    echo 0-7 > /dev/cpuset/$i/cpus
    echo 0 > /dev/cpuset/$i/mems

    [[ ! -f /dev/shm/cpuset/$i/services ]] && continue

    services=$(</dev/shm/cpuset/$i/services)

    for service in $services
    do
        procs=$(</sys/fs/cgroup/system.slice/$service/cgroup.procs)
        while IFS= read -r proc
        do
            [[ "$proc" == "$$" ]] && continue
            echo $proc > /dev/cpuset/$i/tasks
        done <<< "$procs"
    done

done

exit 0
