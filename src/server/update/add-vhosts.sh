#!/usr/bin/env bash

if [ -d "aws/servers/vhosts/$SERVER_IP" ]
then
    VHOSTS=aws/servers/vhosts/$SERVER_IP/*
    for vHost in $VHOSTS
    do
        fileName="$(basename $vHost)"
        scp $vHost ubuntu@$SERVER_IP:~/
        ssh ubuntu@$SERVER_IP "sudo mv ~/$fileName /etc/apache2/sites-available/$fileName"
        vHostName="$(basename $vHost .conf)"
        ssh ubuntu@$SERVER_IP "sudo a2ensite $vHostName"
    done

    ssh ubuntu@$SERVER_IP "sudo service apache2 reload"
fi
