# mbentley/systemd

docker image for systemd on Ubuntu 18.04
based off of Ubuntu 18.04

To pull this image:
`docker pull mbentley/systemd`

Example usage:

```
docker run -td \
  --restart unless-stopped \
  --name systemd-ubuntu \
  --privileged \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
  --tmpfs /tmp \
  mbentley/systemd
```

To shut down the container do the following:

```
docker stop -t 30 systemd-ubuntu
```

___Note___ : the container will not stop properly if you use `init 0`, `halt`, `shutdown -h now`, etc if there is a restart policy set due to the exit code returning as 130

