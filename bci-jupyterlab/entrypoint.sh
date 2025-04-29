#!/bin/bash

JUPYTER_VENV=/app/jupyterlab

# default to uid 1000 inside the container
APP_UNAME=${APP_UNAME:-jupyter}
APP_UID=${APP_UID:-1000}
APP_HOME=/home/${APP_UNAME}

echo "Starting with $APP_UNAME($APP_UID)"
groupadd mail
useradd -s /bin/bash -u $APP_UID -d $APP_HOME -m $APP_UNAME

# useradd will not apply skel files if the container homedir is present, so we force it
cp -ar /etc/skel/. ${APP_HOME}/

# set ownership of homedir and venv to container user
chown -R $APP_UID $APP_HOME
chown -R $APP_UID $JUPYTER_VENV

# setup virtual envs
su - $APP_UNAME -c "python3.6 -mvenv $APP_HOME/venv/3.6"
su - $APP_UNAME -c "$APP_HOME/venv/3.6/bin/pip install ipykernel"
su - $APP_UNAME -c "$APP_HOME/venv/3.6/bin/python -m ipykernel install --user --name=my_env_3.6 --display-name=\"My Env 3.6\""

su - $APP_UNAME -c "python3.11 -mvenv $APP_HOME/venv/3.11"
su - $APP_UNAME -c "$APP_HOME/venv/3.11/bin/pip install ipykernel"
su - $APP_UNAME -c "$APP_HOME/venv/3.11/bin/python -m ipykernel install --user --name=my_env_3.11 --display-name=\"My Env 3.11\""

# Containerfile CMD inside a script to facilitate an exec
echo "$@" > /app/cmd.sh
chmod +x /app/cmd.sh

# exec CMD as the local user 
exec su - $APP_UNAME -c /app/cmd.sh
