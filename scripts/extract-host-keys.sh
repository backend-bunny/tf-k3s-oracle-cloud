#!/usr/bin/env nix-shell
# shellcheck shell=bash
#!nix-shell -i bash -p bash ssh-to-age
set -e

# Usage information
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

IP_ADDRESS=$1
HOSTNAME=$(ssh -o StrictHostKeyChecking=accept-new k3s@"$IP_ADDRESS" "hostname" )

SSH_HOST_PUBLIC_KEY=$(ssh -o StrictHostKeyChecking=accept-new k3s@"$IP_ADDRESS" \
  "sudo cat /etc/ssh/ssh_host_ed25519_key.pub")

AGE_PUBLIC_KEY=$(echo "$SSH_HOST_PUBLIC_KEY" | ssh-to-age)

echo "{ \"hostname\": \"$HOSTNAME\", \"age_public_key\": \"$AGE_PUBLIC_KEY\" }"
