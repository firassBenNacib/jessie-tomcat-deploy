#!/usr/bin/env bash
set -euo pipefail

ENV="${1:-DEV}"

IMAGE_NAME="tomcat_ansible"
CONTAINER_NAME="tomcat_ansible_container"
HOST_PORT=8888
CONTAINER_PORT=8080

echo "Removing leftover container…"
docker rm -f "$CONTAINER_NAME" 2>/dev/null || true

echo "Building image…"
docker build -t "$IMAGE_NAME" .

echo "Running systemd‑enabled container…"
docker run -d --privileged \
  --tmpfs /run \
  --tmpfs /run/lock \
  --cgroupns=host \
  -v /sys/fs/cgroup:/sys/fs/cgroup \
  -v "$(pwd)":/data \
  --name "$CONTAINER_NAME" \
  -e ENV="$ENV" \
  -p "${HOST_PORT}:${CONTAINER_PORT}" \
  "$IMAGE_NAME"

echo "Waiting for systemd to settle…"
sleep 10

echo "Running test script in container…"
docker exec -e ENV="$ENV" "$CONTAINER_NAME" /data/scripts/tomcat_test.sh "$ENV"

echo
echo "Stopping & removing container…"
docker rm -f "$CONTAINER_NAME" >/dev/null
echo "Done."
