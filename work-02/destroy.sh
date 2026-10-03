#!/usr/bin/env bash
set -euo pipefail
PREFIX=tsvetanov-02

if yc load-balancer network-load-balancer get --name "$PREFIX-lb" >/dev/null 2>&1; then
 yc load-balancer network-load-balancer delete "$PREFIX-lb"
fi

if yc load-balancer target-group get --name "$PREFIX-tg" >/dev/null 2>&1; then
 yc load-balancer target-group delete "$PREFIX-tg"
fi

VM_NAMES=$(yc compute instance list --format json | jq -r --arg prefix "$PREFIX-app-" '.[] | select(.name | startswith($prefix)) | .name')
for name in $VM_NAMES; do
 yc compute instance delete "$name"
done

if yc compute disk get --name "$PREFIX-data" >/dev/null 2>&1; then
 yc compute disk delete "$PREFIX-data"
fi

if yc vpc subnet get --name "$PREFIX-subnet-a" >/dev/null 2>&1; then
 yc vpc subnet delete "$PREFIX-subnet-a"
fi

if yc vpc subnet get --name "$PREFIX-subnet-b" >/dev/null 2>&1; then
 yc vpc subnet delete "$PREFIX-subnet-b"
fi

if yc vpc network get --name "$PREFIX-net" >/dev/null 2>&1; then
 yc vpc network delete "$PREFIX-net"
fi
