#!/bin/bash -x

# Reference
# https://docs.vllm.ai/en/latest/getting_started/quickstart.html#installation
# 

# load miniconda3
source ~/miniconda3/bin/activate
conda init --all

# install vllm
conda create -n myenv python=3.10 -y
conda activate myenv
pip install vllm

# list installed packages
conda list -n myenv
conda deactivate

exit $?
