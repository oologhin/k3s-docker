#!/bin/bash




# Install K3s if not already installed
if [ ! -f /usr/local/bin/k3s ]; then
  curl -sfL https://get.k3s.io | sh -
  systemctl enable k3s
fi


# Wait for systemd to initialize
sleep 5

# Start K3s
systemctl start k3s

# Start SSH service
systemctl start ssh
