#!/bin/bash

HOSTS=(
    linode2
    linode-
    adm
    edyta
)

# get HOSTS from cmd line or local file
if [ -n "$1" ] ; then
    unset HOSTS
    HOSTS=$1
elif [ -f hosts.local ] ; then
    unset HOSTS
    source hosts.local
fi

for host in ${HOSTS[*]}; do
    echo "syncing ${host}"
    rsync -av --chown=root:logcheck ignore.d.server/ root@${host}:/etc/logcheck/ignore.d.server
    rsync -av --chown=root:logcheck violations.ignore.d/ root@${host}:/etc/logcheck/violations.ignore.d
done

# rsync -av --chown=root:logcheck ignore.d.server/ root@linode2:/etc/logcheck/ignore.d.server
# rsync -av --chown=root:logcheck ignore.d.server/ root@adm:/etc/logcheck/ignore.d.server
# rsync -av --chown=root:logcheck ignore.d.server/ root@edyta.org.pl:/etc/logcheck/ignore.d.server
