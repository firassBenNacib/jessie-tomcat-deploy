FROM debian:jessie

LABEL maintainer="Firas Ben Nacib <bennacibfiras@gmail.com>"

ENV container=docker
ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

RUN echo "deb http://archive.debian.org/debian jessie main contrib" > /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until && \
    apt-get update && \
    apt-get install -y --allow-unauthenticated \
        systemd systemd-sysv dbus \
        python python-apt curl gnupg ca-certificates && \
    curl -sSL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python && \
    pip install --no-cache-dir ansible==2.9.27 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME ["/sys/fs/cgroup"]
STOPSIGNAL SIGRTMIN+3

EXPOSE 8080

COPY scripts/fix-dbus.sh /fix-dbus.sh
RUN chmod +x /fix-dbus.sh

CMD ["/fix-dbus.sh"]