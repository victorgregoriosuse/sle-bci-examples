#!/bin/bash

# default to uid 1000 inside the container
CONT_UID=${APP_UID:-1000}
CONT_UNAME=jupyter

CONT_HOME=/home/${CONT_UNAME}
VIRTENV=/app/venv

echo "Starting with $CONT_UNAME($CONT_UID)"
groupadd mail
useradd -s /bin/bash -u $CONT_UID -d $CONT_HOME -m $CONT_UNAME

# useradd will not apply skel files if the container homedir is present, so we force it
cp -ar /etc/skel/. ${CONT_HOME}/

# set ownership of homedir and venv to container user
chown -R $CONT_UID $CONT_HOME
chown -R $CONT_UID $VIRTENV

# Containerfile CMD inside a script to facilitate an exec
echo "$@" > /app/cmd.sh
chmod +x /app/cmd.sh

# exec CMD as the local user 
exec su - $CONT_UNAME -c /app/cmd.sh