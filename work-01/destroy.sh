#!/usr/bin/env bash
set -euo pipefail

PREFIX="tsvetanov-02"

yc compute instance delete "$PREFIX-app-1"
yc compute instance delete "$PREFIX-app-2"
yc vpc subnet delete "$PREFIX-subnet"
yc vpc network delete "$PREFIX-net"
