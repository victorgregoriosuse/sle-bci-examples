# https://registry.suse.com/
FROM registry.suse.com/bci/bci-base:latest

# packages
ENV ZYPPERCMD="zypper --non-interactive"
RUN $ZYPPERCMD install python3 python3-pip python3-virtualenv
RUN $ZYPPERCMD install python311 python311-pip python311-virtualenv

# clean up
RUN $ZYPPERCMD clean --all 

# jupyter main virtenv
ENV JUPYTER_VENV=/app/jupyterlab
RUN python3.11 -m venv ${JUPYTER_VENV}
RUN ${JUPYTER_VENV}/bin/pip3 install jupyterlab

# jupyterlab default port
EXPOSE 8888 

# set up an entrypoint to allow exec of jupyter as non-root user in the container
WORKDIR /app
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]

# this is consumed by the entrypoint script
CMD ["/app/jupyterlab/bin/jupyter", "lab", "--no-browser", "--ip=0.0.0.0", "--port=8888"]
