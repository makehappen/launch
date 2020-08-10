#!/usr/bin/env bash

# call script with
# SERVER_IP=... && . src/server/setup.sh

# generate ssh key
ssh -i $AWS_PEM_KEY_PATH ubuntu@$SERVER_IP "ssh-keygen -q -t rsa -N '' <<< ""$'\n'"y" 2>&1 >/dev/null"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$SERVER_IP "chmod 400 ~/.ssh/id_rsa"
ssh -i $AWS_PEM_KEY_PATH ubuntu@$SERVER_IP "exec ssh-agent && ssh-add ~/.ssh/id_rsa"

# download pem authorized_key
scp -i $AWS_PEM_KEY_PATH ubuntu@$SERVER_IP:~/.ssh/authorized_keys aws/servers/authorized_keys/$SERVER_IP.txt

# add current user ssh key
cat ~/.ssh/id_rsa.pub >> aws/servers/authorized_keys/$SERVER_IP.txt

# upload updated authorized_keys file
[[ -f aws/servers/authorized_keys/$SERVER_IP.txt ]] \
    && scp -i $AWS_PEM_KEY_PATH aws/servers/authorized_keys/$SERVER_IP.txt ubuntu@$SERVER_IP:~/.ssh/authorized_keys_temp

# rename file
ssh -i $AWS_PEM_KEY_PATH ubuntu@$SERVER_IP "sudo mv ~/.ssh/authorized_keys_temp ~/.ssh/authorized_keys"

# upload composer_auth
. src/server/update/composer-auth.sh
