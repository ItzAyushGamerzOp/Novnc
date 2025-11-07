#!/bin/bash
# Start VNC server
vncserver :1 -geometry 1280x720 -depth 16

# Start noVNC
mkdir -p /root/noVNC
cd /root/noVNC
git clone https://github.com/novnc/noVNC.git .
git clone https://github.com/novnc/websockify.git ./utils/websockify

# Run the noVNC web server
./utils/novnc_proxy --vnc localhost:5901 --listen 6080
