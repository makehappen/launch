#!/usr/bin/env bash

# call script with
# SERVER_IP=... && . src/server/update-authorized-keys.sh

# upload updated authorized_keys file
[[ -f aws/servers/authorized_keys/$SERVER_IP.txt ]] \
    && scp aws/servers/authorized_keys/$SERVER_IP.txt ubuntu@$SERVER_IP:~/.ssh/authorized_keys_temp

