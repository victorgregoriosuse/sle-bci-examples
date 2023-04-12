#!/bin/bash

source /opt/intel/oneapi/setvars.sh || exit 1

pip3 -v
python -v

exit $?
