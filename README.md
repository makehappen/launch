# launch

## Pre-requisites

### AWS CLI
[https://aws.amazon.com/cli/](https://aws.amazon.com/cli/)

### AWS CLI User Profile
[https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)

## Images

### Create New Image
```bash
AWS_PROFILE=
AWS_IMAGE=
AWS_IMAGE_CONFIG= 
. src/image/create.sh
```
### Build New Image
```bash
IMAGE_IP= 
AWS_IMAGE_CONFIG=
. src/image/build.sh
```

## Servers

### Launch New Server
```bash
AWS_PROFILE=
LAUNCH_CONFIG=
. src/server/launch.sh
```
### Setup New Server
```bash
SERVER_IP=
. src/server/setup.sh
```
### Maintain Server

#### Get Server SSH KEY
```bash
SERVER_IP=
. src/server/get-ssh-key.sh
```
#### Update Authorized Keys
```bash
SERVER_IP=
. src/server/update/authorized-keys.sh
```

#### Update Composer Auth
```bash
SERVER_IP=
. src/server/update/composer-auth.sh
```
#### Update vHosts
```bash
SERVER_IP=
. src/server/update/add-vhosts.sh
```
