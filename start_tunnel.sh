#!/bin/sh
[ $# -lt 2 ] && { echo "Usage: $0 port_of_local_service hostname" ; exit 1; }
ssh -N -o ExitOnForwardFailure=yes -o ServerAliveInterval=300 -o ConnectTimeout=5 -g -R 8080:localhost:$1 -p 2222 tunnel@$2