#!/bin/bash

procs=$(</sys/fs/cgroup/user.slice/user-$UID.slice/user@$UID.service/session.slice/$1/cgroup.procs)
while IFS= read -r proc
do
    [[ "$proc" == "$$" ]] && continue
    echo $proc > /dev/cpuset/$2/tasks
done <<< "$procs"

exit 0
