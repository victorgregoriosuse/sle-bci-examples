# SLE BCI container with JupyterLab

## Requirements

- Storage: image is ~549 MB

## Docker Deployment

### 1. Build Image
```bash
docker buildx build -t bci-jupyterlab -f Dockerfile .
```

### 2. Configure & Run

The `compose.yml` requires environment variables to be set beforehand

#### **Variables**

* `APP_UNAME`:  the conainer username that runs jupyterhub (default = jupyter)
* `APP_UID`:    the uid for the container username (default = 1000)

#### **Example Run**
```bash
export APP_UNAME=$USER
export APP_UID=$(id -u)

docker compose up
```
Watch the output for a URL that contains the auth token.  The access port is mapped in `compose.yml`.

# Reference

- https://denibertovic.com/posts/handling-permissions-with-docker-volumes/






