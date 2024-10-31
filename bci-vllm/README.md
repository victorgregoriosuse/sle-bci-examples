# README

vLLM, or Virtual Large Language Model, is an open-source library that helps with the serving and inference of large language models (LLMs).  This repositiory provides a vLLM container on SUSE SLE Base Container Images (BCI) deployed as a server that implements the OpenAI API protocol.

## PREP HOST

### Configure CDI

To launch a podman container with GPU access on SLES, first configure the Container Device Interface in `/etc/cdi/nvidia.yaml` using the NVIDIA Container Toolkit.  See instructions here: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html#procedure

### Install crun

If you plan to access NVIDIA GPUs from a podman container as a non-root user, you will need to use the crun runtime found in SUSE's Package Hub repository: https://packagehub.suse.com/packages/crun/

```
zypper install crun
```

## BUILD CONTAINER

```
podman build -t sle-vllm -f Containerfile
```

## EXAMPLE RUN

To launch as non-root user on SLES, 

1. Your user must belong to the `video` group for access to /dev/nvidia*
2. Use the crun runtime which supports group mapping (`--runtime=crun`)
3. Use `--group-add keep-groups` to map host groups to container groups

```
podman run --rm -it --device nvidia.com/gpu=all --runtime=crun --group-add keep-groups -p 8000:8000 --name sle-vllm sle-vllm
```

Then, in the interactive shell, load the Miniconda environment:

```
source ~/miniconda3/bin/activate
conda init --all
conda activate myenv
```

Optionally login to HuggingFace. Some models will require authentication.

```
(myenv) huggingface-cli login --token <YOUR_TOKEN>
```

Launch vLLM Serve

```
(myenv) vllm serve "mistralai/Mistral-7B-Instruct-v0.2"
```

The model will be downloaded if needed and it will take some time for the server to launch.  Wait until you see this message before attempting to connect to the service.

```
INFO:     Started server process [39]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on socket ('0.0.0.0', 8000) (Press CTRL+C to quit)
```

### Runtime Chat Template Errors

Some models do not provide a chat template. For those models, manually specify their chat template in the `--chat-template` parameter.  If you get this error, you will need a chat template:

```
As of transformers v4.44, default chat template is no longer allowed, so you must provide a chat template if the tokenizer does not define one.
```

See: https://docs.vllm.ai/en/latest/serving/openai_compatible_server.html?ref=blog.mozilla.ai#chat-template

## REFERENCE

* vLLM: https://docs.vllm.ai/en/v0.6.0/getting_started/quickstart.html
* Miniconda: https://docs.anaconda.com/miniconda/
* SUSE SLE BCI: https://www.suse.com/products/base-container-images/
* NVIDIA Container Device Interface: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/cdi-support.html

## MINICONDA BOM

### Installed Packages

```
The following NEW packages will be INSTALLED:

  _libgcc_mutex      pkgs/main/linux-64::_libgcc_mutex-0.1-main 
  _openmp_mutex      pkgs/main/linux-64::_openmp_mutex-5.1-1_gnu 
  bzip2              pkgs/main/linux-64::bzip2-1.0.8-h5eee18b_6 
  ca-certificates    pkgs/main/linux-64::ca-certificates-2024.9.24-h06a4308_0 
  ld_impl_linux-64   pkgs/main/linux-64::ld_impl_linux-64-2.40-h12ee557_0 
  libffi             pkgs/main/linux-64::libffi-3.4.4-h6a678d5_1 
  libgcc-ng          pkgs/main/linux-64::libgcc-ng-11.2.0-h1234567_1 
  libgomp            pkgs/main/linux-64::libgomp-11.2.0-h1234567_1 
  libstdcxx-ng       pkgs/main/linux-64::libstdcxx-ng-11.2.0-h1234567_1 
  libuuid            pkgs/main/linux-64::libuuid-1.41.5-h5eee18b_0 
  ncurses            pkgs/main/linux-64::ncurses-6.4-h6a678d5_0 
  openssl            pkgs/main/linux-64::openssl-3.0.15-h5eee18b_0 
  pip                pkgs/main/linux-64::pip-24.2-py310h06a4308_0 
  python             pkgs/main/linux-64::python-3.10.15-he870216_1 
  readline           pkgs/main/linux-64::readline-8.2-h5eee18b_0 
  setuptools         pkgs/main/linux-64::setuptools-75.1.0-py310h06a4308_0 
  sqlite             pkgs/main/linux-64::sqlite-3.45.3-h5eee18b_0 
  tk                 pkgs/main/linux-64::tk-8.6.14-h39e8969_0 
  tzdata             pkgs/main/noarch::tzdata-2024b-h04d1e81_0 
  wheel              pkgs/main/linux-64::wheel-0.44.0-py310h06a4308_0 
  xz                 pkgs/main/linux-64::xz-5.4.6-h5eee18b_1 
  zlib               pkgs/main/linux-64::zlib-1.2.13-h5eee18b_1 
```

### Full BOM

```
# packages in environment at /root/miniconda3/envs/myenv:
#
# Name                    Version                   Build  Channel
_libgcc_mutex             0.1                        main  
_openmp_mutex             5.1                       1_gnu  
aiohappyeyeballs          2.4.3                    pypi_0    pypi
aiohttp                   3.10.10                  pypi_0    pypi
aiosignal                 1.3.1                    pypi_0    pypi
annotated-types           0.7.0                    pypi_0    pypi
anyio                     4.6.2.post1              pypi_0    pypi
async-timeout             4.0.3                    pypi_0    pypi
attrs                     24.2.0                   pypi_0    pypi
bzip2                     1.0.8                h5eee18b_6  
ca-certificates           2024.9.24            h06a4308_0  
certifi                   2024.8.30                pypi_0    pypi
charset-normalizer        3.4.0                    pypi_0    pypi
click                     8.1.7                    pypi_0    pypi
cloudpickle               3.1.0                    pypi_0    pypi
compressed-tensors        0.6.0                    pypi_0    pypi
datasets                  3.0.2                    pypi_0    pypi
dill                      0.3.8                    pypi_0    pypi
diskcache                 5.6.3                    pypi_0    pypi
distro                    1.9.0                    pypi_0    pypi
einops                    0.8.0                    pypi_0    pypi
exceptiongroup            1.2.2                    pypi_0    pypi
fastapi                   0.115.4                  pypi_0    pypi
filelock                  3.16.1                   pypi_0    pypi
frozenlist                1.5.0                    pypi_0    pypi
fsspec                    2024.9.0                 pypi_0    pypi
gguf                      0.10.0                   pypi_0    pypi
h11                       0.14.0                   pypi_0    pypi
httpcore                  1.0.6                    pypi_0    pypi
httptools                 0.6.4                    pypi_0    pypi
httpx                     0.27.2                   pypi_0    pypi
huggingface-hub           0.26.2                   pypi_0    pypi
idna                      3.10                     pypi_0    pypi
importlib-metadata        8.5.0                    pypi_0    pypi
interegular               0.3.3                    pypi_0    pypi
jinja2                    3.1.4                    pypi_0    pypi
jiter                     0.6.1                    pypi_0    pypi
jsonschema                4.23.0                   pypi_0    pypi
jsonschema-specifications 2024.10.1                pypi_0    pypi
lark                      1.2.2                    pypi_0    pypi
ld_impl_linux-64          2.40                 h12ee557_0  
libffi                    3.4.4                h6a678d5_1  
libgcc-ng                 11.2.0               h1234567_1  
libgomp                   11.2.0               h1234567_1  
libstdcxx-ng              11.2.0               h1234567_1  
libuuid                   1.41.5               h5eee18b_0  
llvmlite                  0.43.0                   pypi_0    pypi
lm-format-enforcer        0.10.6                   pypi_0    pypi
markupsafe                3.0.2                    pypi_0    pypi
mistral-common            1.4.4                    pypi_0    pypi
mpmath                    1.3.0                    pypi_0    pypi
msgpack                   1.1.0                    pypi_0    pypi
msgspec                   0.18.6                   pypi_0    pypi
multidict                 6.1.0                    pypi_0    pypi
multiprocess              0.70.16                  pypi_0    pypi
ncurses                   6.4                  h6a678d5_0  
nest-asyncio              1.6.0                    pypi_0    pypi
networkx                  3.4.2                    pypi_0    pypi
numba                     0.60.0                   pypi_0    pypi
numpy                     1.26.4                   pypi_0    pypi
nvidia-cublas-cu12        12.1.3.1                 pypi_0    pypi
nvidia-cuda-cupti-cu12    12.1.105                 pypi_0    pypi
nvidia-cuda-nvrtc-cu12    12.1.105                 pypi_0    pypi
nvidia-cuda-runtime-cu12  12.1.105                 pypi_0    pypi
nvidia-cudnn-cu12         9.1.0.70                 pypi_0    pypi
nvidia-cufft-cu12         11.0.2.54                pypi_0    pypi
nvidia-curand-cu12        10.3.2.106               pypi_0    pypi
nvidia-cusolver-cu12      11.4.5.107               pypi_0    pypi
nvidia-cusparse-cu12      12.1.0.106               pypi_0    pypi
nvidia-ml-py              12.560.30                pypi_0    pypi
nvidia-nccl-cu12          2.20.5                   pypi_0    pypi
nvidia-nvjitlink-cu12     12.6.77                  pypi_0    pypi
nvidia-nvtx-cu12          12.1.105                 pypi_0    pypi
openai                    1.52.2                   pypi_0    pypi
opencv-python-headless    4.10.0.84                pypi_0    pypi
openssl                   3.0.15               h5eee18b_0  
outlines                  0.0.46                   pypi_0    pypi
packaging                 24.1                     pypi_0    pypi
pandas                    2.2.3                    pypi_0    pypi
partial-json-parser       0.2.1.1.post4            pypi_0    pypi
pillow                    10.4.0                   pypi_0    pypi
pip                       24.2            py310h06a4308_0  
prometheus-client         0.21.0                   pypi_0    pypi
prometheus-fastapi-instrumentator 7.0.0                    pypi_0    pypi
propcache                 0.2.0                    pypi_0    pypi
protobuf                  5.28.3                   pypi_0    pypi
psutil                    6.1.0                    pypi_0    pypi
py-cpuinfo                9.0.0                    pypi_0    pypi
pyairports                2.1.1                    pypi_0    pypi
pyarrow                   18.0.0                   pypi_0    pypi
pycountry                 24.6.1                   pypi_0    pypi
pydantic                  2.9.2                    pypi_0    pypi
pydantic-core             2.23.4                   pypi_0    pypi
python                    3.10.15              he870216_1  
python-dateutil           2.9.0.post0              pypi_0    pypi
python-dotenv             1.0.1                    pypi_0    pypi
pytz                      2024.2                   pypi_0    pypi
pyyaml                    6.0.2                    pypi_0    pypi
pyzmq                     26.2.0                   pypi_0    pypi
ray                       2.38.0                   pypi_0    pypi
readline                  8.2                  h5eee18b_0  
referencing               0.35.1                   pypi_0    pypi
regex                     2024.9.11                pypi_0    pypi
requests                  2.32.3                   pypi_0    pypi
rpds-py                   0.20.0                   pypi_0    pypi
safetensors               0.4.5                    pypi_0    pypi
sentencepiece             0.2.0                    pypi_0    pypi
setuptools                75.1.0          py310h06a4308_0  
six                       1.16.0                   pypi_0    pypi
sniffio                   1.3.1                    pypi_0    pypi
sqlite                    3.45.3               h5eee18b_0  
starlette                 0.41.2                   pypi_0    pypi
sympy                     1.13.3                   pypi_0    pypi
tiktoken                  0.7.0                    pypi_0    pypi
tk                        8.6.14               h39e8969_0  
tokenizers                0.20.1                   pypi_0    pypi
torch                     2.4.0                    pypi_0    pypi
torchvision               0.19.0                   pypi_0    pypi
tqdm                      4.66.6                   pypi_0    pypi
transformers              4.46.1                   pypi_0    pypi
triton                    3.0.0                    pypi_0    pypi
typing-extensions         4.12.2                   pypi_0    pypi
tzdata                    2024.2                   pypi_0    pypi
urllib3                   2.2.3                    pypi_0    pypi
uvicorn                   0.32.0                   pypi_0    pypi
uvloop                    0.21.0                   pypi_0    pypi
vllm                      0.6.3.post1              pypi_0    pypi
watchfiles                0.24.0                   pypi_0    pypi
websockets                13.1                     pypi_0    pypi
wheel                     0.44.0          py310h06a4308_0  
xformers                  0.0.27.post2             pypi_0    pypi
xxhash                    3.5.0                    pypi_0    pypi
xz                        5.4.6                h5eee18b_1  
yarl                      1.17.0                   pypi_0    pypi
zipp                      3.20.2                   pypi_0    pypi
zlib                      1.2.13               h5eee18b_1 
```

