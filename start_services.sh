#!/bin/bash

# Start Docker
service docker start

# Install K3s if not already installed
if [ ! -f /usr/local/bin/k3s ]; then
  curl -sfL https://get.k3s.io | sh -
fi

# Start K3s server
/usr/local/bin/k3s server &

# Start SSH service
service ssh start

# Keep the container running
tail -f /dev/null
