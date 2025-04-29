# https://registry.suse.com/
FROM registry.suse.com/bci/bci-base:latest

# packages
ENV ZYPPERCMD="zypper --non-interactive"
RUN $ZYPPERCMD install python3 python3-pip python3-virtualenv
RUN $ZYPPERCMD install python311 python311-pip python311-virtualenv
RUN $ZYPPERCMD install nodejs npm

# clean up
RUN $ZYPPERCMD clean --all 

# jupyter main virtenv
ENV JUPYTER_VENV=/app/jupyterhub
RUN python3.11 -m venv ${JUPYTER_VENV}
RUN ${JUPYTER_VENV}/bin/pip3 install wheel jupyterlab jupyterhub ipywidgets
RUN npm install -g configurable-http-proxy

# jupyterhub config file
RUN mkdir -p ${JUPYTER_VENV}/etc/jupyterhub/
COPY jupyterhub_config.py ${JUPYTER_VENV}/etc/jupyterhub/jupyterhub_config.py

# jupyterhub default port
EXPOSE 8888 

# set up an entrypoint to allow exec of jupyter as non-root user in the container
WORKDIR /app
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]

# this is consumed by the entrypoint script
CMD ["/app/jupyterhub/bin/jupyterhub", "-f", "/app/jupyterhub/etc/jupyterhub/jupyterhub_config.py"]
