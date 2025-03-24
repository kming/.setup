#!/bin/sh
set -e

if [ $# -ne 3 ]; then
    echo "Usage: $0 <server-machine> <user> <port>"
    exit 1
fi

# Static config for now with some args
login_server=$1
user=$2
client_viewer="/Applications/TigerVNC\ Viewer\ 1.14.1.app/Contents/MacOS/TigerVNC\ Viewer"
port_prefix="59"
port="${port_prefix}${3}"

# Forward the port, and give it a bogus sleep cmd to prevent sleep
echo "Forwarding $port from $login_server:$user"
ssh_cmd="ssh -f -L ${port}:localhost:${port} -l $user $login_server sleep 5s"
echo " - Running $ssh_cmd"
eval $ssh_cmd

# Connect to the VNC Server
echo "Starting VNC Server to localhost:$port"
vnc_cmd="$client_viewer localhost:${port}"
echo " - Running $vnc_cmd"
eval $vnc_cmd
