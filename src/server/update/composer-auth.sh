#!/usr/bin/env bash

# call script with
# SERVER_IP=... && . src/server/update-composer-auth.sh

[[ -f aws/servers/composer/$SERVER_IP.json ]] \
    && scp aws/servers/composer/$SERVER_IP.json ubuntu@$SERVER_IP:~/.config/composer/auth.json


