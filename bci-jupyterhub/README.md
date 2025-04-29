# SLE BCI container with JupyterHub

## Requirements

- Storage: image is ~787 MB

## Docker Deployment

### 1. Build Image
```bash
docker buildx build -t bci-jupyterhub -f Dockerfile .
```

### 2. Configure & Run

The `compose.yml` requires environment variables to be set beforehand

#### **Variables**

* `APP_UNAME`:  the conainer username that runs jupyterhub (default = jupyter)
* `APP_UID`:    the uid for the container username (default = 1000)
* `APP_PASS`:   the password for the container username (default = CHANGEME)

#### **Example Run**
```bash
export APP_PASS="YOUR_SECURE_PASSWORD_HERE"
export APP_UNAME=$USER
export APP_UID=$(id -u)

docker compose up -d
```
Access via port mapped in `compose.yml` (e.g., `http://localhost:8888`)

# Kubernetes / Rancher Deployment (Helm)

See [bci-jupyterhub-helm/README.md](./bci-jupyterhub-helm/README.md)

# Reference

- https://denibertovic.com/posts/handling-permissions-with-docker-volumes/
- https://registry.suse.com/
- https://jupyter.org/





