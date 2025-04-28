# https://registry.suse.com/
FROM registry.suse.com/bci/bci-base:latest

# packages
ENV ZYPPERCMD="zypper --non-interactive"
RUN $ZYPPERCMD install python311 python311-pip python311-virtualenv
RUN $ZYPPERCMD clean --all 

# jupyter main virtenv
ENV JUPYTER_VENV=/app/venv/python311
RUN python3.11 -m venv ${JUPYTER_VENV}
RUN ${JUPYTER_VENV}/bin/pip3 install jupyterlab
RUN ${JUPYTER_VENV}/bin/pip3 install ipykernel

# unnecessary
#RUN ${JUPYTER_VENV}/bin/python3 -m ipykernel install --sys-prefix --prefix="/app/venv/python311" --name python-3.11-env --display-name "Python 3.11" 

# jupyterlab default port
EXPOSE 8888 

# set up an entrypoint to allow exec of jupyter as non-root user in the container
WORKDIR /app
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]

# this is consumed by the entrypoint script
CMD ["/app/venv/python311/bin/jupyter", "lab", "--no-browser", "--ip=0.0.0.0", "--port=8888"]
