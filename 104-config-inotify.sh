#!/bin/sh
set -x

cat <<EOF | sudo tee -a /etc/sysctl.d/k8s.conf
fs.inotify.max_queued_events =1048576
fs.inotify.max_user_instances=1048576
fs.inotify.max_user_watches  =1048576
EOF


sudo sysctl --system

