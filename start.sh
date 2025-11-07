#!/bin/bash
echo "----- Starting VNC + noVNC server -----"

mkdir -p /root/.vnc
echo "1234" | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

# Start desktop environment
vncserver :1 -geometry 1280x800 -depth 24
sleep 3

# Start noVNC proxy
/usr/share/novnc/utils/novnc_proxy --vnc localhost:5901 --listen 0.0.0.0:6080 &
sleep 2

echo "✅ noVNC is running on port 6080"
echo "👉 Access: https://your-app-name.onrender.com"
echo "🔑 Password: 1234"

# Keep container alive
tail -f /dev/null
