#!/bin/bash -x 

# Reference
# https://docs.anaconda.com/miniconda/
# 

# download and install
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3

# remove installer
rm -f ~/miniconda3/miniconda.sh

exit $?
