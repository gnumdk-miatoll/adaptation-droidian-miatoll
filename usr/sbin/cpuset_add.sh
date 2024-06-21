#!/bin/bash

# Some services are runned to early
if ! grep 0 /dev/cpuset/$2/mems >/dev/null 2>&1 
then
    mkdir -p /dev/shm/cpuset/$2
    echo $1 >> /dev/shm/cpuset/$2/services
    exit 0
fi

procs=$(</sys/fs/cgroup/system.slice/$1/cgroup.procs)
while IFS= read -r proc
do
    [[ "$proc" == "$$" ]] && continue
    echo $proc > /dev/cpuset/$2/tasks
done <<< "$procs"

exit 0
