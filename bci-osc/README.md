# SLE BCI container with OSC

- https://registry.suse.com/
- https://en.opensuse.org/openSUSE:OSC


# Build

```
docker buildx build -t bci-osc -f Containerfile .
```

#  Run

```
docker run -it bci-osc
```