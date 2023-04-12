#
# Install Intel oneAPI AI Toolkit on SUSE SLE BCI
#
# https://www.intel.com/content/www/us/en/developer/tools/oneapi/toolkits.html#base-kit

# https://registry.suse.com/
FROM registry.suse.com/bci/bci-base:latest

ENV ZYPPERCMD="zypper --non-interactive"

RUN $ZYPPERCMD addrepo https://yum.repos.intel.com/oneapi oneAPI
RUN rpm --import https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB

# prerequisites
RUN $ZYPPERCMD install awk python3 python3-pip

# install oneAPI
RUN $ZYPPERCMD install intel-aikit 
RUN $ZYPPERCMD clean --all

# install pip packages
WORKDIR /root
COPY pip-installs.sh . 
RUN bash ./pip-installs.sh
