#!/bin/sh

# call script with
# AWS_IMAGE=... && AWS_IMAGE_CONFIG=... && . src/image/create.sh

. aws/images/$AWS_IMAGE/image.sh
. aws/images/config/$AWS_IMAGE_CONFIG.sh

# create ec2 instance from aws image
aws ec2 run-instances \
    --image-id $AWS_IMAGE_ID \
    --count 1 \
    --instance-type t3.nano \
    --key-name $AWS_KEY_NAME \
    --associate-public-ip-address \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$AWS_IMAGE_NAME}]" \
    --subnet-id $AWS_SUBNET_ID \
    --security-group-ids $AWS_SECURITY_GROUPS_IDS \
    --block-device-mappings "[{\"DeviceName\":\"/dev/sda1\",\"Ebs\":{\"VolumeSize\":$AWS_VOLUM_SIZE,\"DeleteOnTermination\":true,\"Encrypted\":true,\"VolumeType\": \"gp2\"}}]"

