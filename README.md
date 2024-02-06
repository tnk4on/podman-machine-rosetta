# How to manually enable Rosetta on a Podman machine

This is a temporary solution until the feature is implemented in Podman v5.

## Step

0. `export CONTAINERS_MACHINE_PROVIDER=applehv`
1. `podman machine init`
2. Add settings for rosetta in `podman-machine-default.json`
```
% vi ~/.config/containers/podman/machine/applehv/podman-machine-default.json
```

Add the following code in `"devices": []`
```
    {
     "kind": "rosetta",
     "MountTag": "rosetta",
     "InstallRosetta": false
    }
```
3. `podman machine start`
4. `podman machine os apply quay.io/tnk4on/rosetta --restart`
5. After the Podman machine restart is complete, you can run containers with rosetta
```
% podman machine ssh sudo cat /proc/sys/fs/binfmt_misc/rosetta
enabled
interpreter /mnt/rosetta/rosetta
flags: F
offset 0
magic 7f454c4602010100000000000000000002003e00
mask fffffffffffefe00fffffffffffffffffeffffff

% podman run --rm --arch amd64 ubi9 uname -m
x86_64
```

## How to manually build a custom OCI Image

```
git clone https://github.com/tnk4on/podman-machine-rosetta.git
cd podman-machine-rosetta
podman build -t rosetta .
podman push rosetta quay.io/tnk4on/rosetta
```