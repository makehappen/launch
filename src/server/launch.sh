#!/bin/sh

# call script with
# LAUNCH_CONFIG=... && . src/server/launch.sh

# load config
. aws/servers/launch-config/$LAUNCH_CONFIG.sh

# create ec2 instance from owned image
aws ec2 run-instances \
    --image-id $AWS_IMAGE_ID \
    --count 1 \
    --instance-type $AWS_INSTANCE_TYPE \
    --key-name $AWS_KEY_NAME \
    --associate-public-ip-address \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$AWS_SERVER_NAME}]" \
    --subnet-id $AWS_SUBNET_ID \
    --security-group-ids $AWS_SECURITY_GROUPS_IDS \
    --block-device-mappings "[{\"DeviceName\":\"/dev/sda1\",\"Ebs\":{\"VolumeSize\":$AWS_VOLUME_SIZE,\"DeleteOnTermination\":true,\"Encrypted\":true,\"VolumeType\": \"gp2\"}}]"
