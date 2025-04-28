#!/bin/bash -x

# Reference
# https://docs.vllm.ai/en/latest/getting_started/quickstart.html#openai-compatible-server
#

VLLM_ARGS="$@"
if [ -z "${VLLM_ARGS}" ]; then echo "${0##*/}: VLLM_ARGS environment variable is not set" >&2; exit 1; fi

# load miniconda3
source ~/miniconda3/bin/activate
conda init --all

# activate env and launch vllm serve
conda activate myenv
vllm serve $VLLM_ARGS

exit $?
