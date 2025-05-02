#!/bin/bash
set -e

mkdir -p /run/dbus

dbus-daemon --system --fork

exec /lib/systemd/systemd
