# rebased/repackaged base image that only updates existing packages
FROM mbentley/ubuntu:20.04
LABEL maintainer="Matt Bentley <mbentley@mbentley.net>"

ENV container=docker LC_ALL=C

RUN apt-get update &&\
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends systemd systemd-sysv &&\
  systemctl set-default multi-user.target &&\
  rm -rf /var/lib/apt/lists/* &&\
  rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/basic.target.wants/* \
    /lib/systemd/system/anaconda.target.wants/* \
    /lib/systemd/system/plymouth* \
    /lib/systemd/system/systemd-update-utmp* &&\
  (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ "${i}" = "systemd-tmpfiles-setup.service" ] || rm -f "${i}"; done);

STOPSIGNAL SIGRTMIN+3
CMD ["/lib/systemd/systemd"]
