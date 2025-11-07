#!/bin/bash
echo "Starting VNC server..."
mkdir -p /root/.vnc
echo "1234" | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

# start xfce desktop and vnc
vncserver :1 -geometry 1280x800 -depth 24
sleep 3

echo "Starting noVNC..."
/usr/share/novnc/utils/novnc_proxy --vnc localhost:5901 --listen 0.0.0.0:6080 &

echo "noVNC running on port 6080"
echo "Open this in browser after deploy: https://your-app-name.onrender.com"

# keep alive
tail -f /dev/null
