#!/bin/bash
echo "----- Starting VNC + noVNC with Chrome (Lite) -----"

# Kill any old session
vncserver -kill :1 >/dev/null 2>&1 || true

# Start new VNC session
vncserver :1 -geometry 1280x720 -depth 16
export DISPLAY=:1

# Launch lightweight panel
xfce4-session &

# ✅ Start noVNC
cd /root
if [ ! -d "noVNC" ]; then
  git clone https://github.com/novnc/noVNC.git --depth=1
  git clone https://github.com/novnc/websockify.git --depth=1 noVNC/utils/websockify
fi

echo "✅ noVNC is running on port 6080"
echo "🔑 Password: 1234"
echo "🌐 Access: https://<your-app-name>.onrender.com"

# ✅ Launch Chrome in background for testing
chromium-browser --no-sandbox --disable-gpu --disable-dev-shm-usage &

cd noVNC
./utils/novnc_proxy --vnc localhost:5901 --listen 6080
