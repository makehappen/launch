# launch


## Images

### Create New Image
```bash
AWS_IMAGE=...
AWS_IMAGE_CONFIG=... 
. src/image/create.sh
```
### Build New Image
```bash
IMAGE_IP=... 
AWS_IMAGE_CONFIG=...
. src/image/build.sh
```

## Servers

### Launch New Server
```bash
LAUNCH_CONFIG=...
. src/server/launch.sh
```
### Setup New Server
```bash
SERVER_IP=...
. src/server/setup.sh
```
### Maintain Server

#### Get Server SSH KEY
```bash
SERVER_IP=...
. src/server/get-ssh-key.sh
```
#### Update Authorized Keys
```bash
SERVER_IP=...
. src/server/update/authorized-keys.sh
```

#### Update Composer Auth
```bash
SERVER_IP=...
. src/server/update/composer-auth.sh
```
