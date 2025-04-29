# Deploying the BCI JupyterHub Chart

Follow these steps to configure the necessary password secret and install the Helm chart.

## Requirements

* `kubectl` configured for your target Kubernetes cluster.
* `helm` v3+ installed.
* You are in the directory containing the Helm chart source (e.g., `bci-jupyterhub-helm/`).
* Remote access to https://hub.docker.com/r/victorgregoriosuse/bci-jupyterhub

## Steps

### 1. Edit Helm (optional)

`values.yaml` configures the container username and container username's UID

```yaml
env:
  APP_UNAME: "suse"
  APP_UID: 1001
```

### 2. Set Namespace and Password
```bash
export NAMESPACE="jupyterhub"
export RELEASE_NAME="my-jupyterhub"
export YOUR_PASSWORD="YOUR_SECURE_PASSWORD_HERE"
```
*Replace `YOUR_SECURE_PASSWORD_HERE` with your desired strong password.*

### 3. Create Namespace and Secret
This command creates the Kubernetes namespace (if it doesn't exist) and the required secret directly, without needing manual base64 encoding or a YAML file.
```bash
kubectl create namespace "${NAMESPACE}" --dry-run=client -o yaml | kubectl apply -f -
kubectl create secret generic jupyter-secret \
    --from-literal=app_pass="${YOUR_PASSWORD}" \
    -n "${NAMESPACE}"
```

### 4. Install the Helm Chart
Now, install the chart from your local source into the namespace where the secret was created.
```bash
helm install "${RELEASE_NAME}" . -n "${NAMESPACE}"
```

Your JupyterHub instance should now be deploying.