#!/bin/bash
echo "----- Starting VNC + noVNC server -----"

# Start VNC
vncserver :1 -geometry 1280x720 -depth 16

# Clone latest noVNC
cd /root
git clone https://github.com/novnc/noVNC.git
git clone https://github.com/novnc/websockify.git noVNC/utils/websockify

# Run noVNC server
cd noVNC
echo "✅ noVNC is running on port 6080"
echo "🔑 Password: 1234"
./utils/novnc_proxy --vnc localhost:5901 --listen 6080
