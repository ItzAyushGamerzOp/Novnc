#!/bin/bash
echo "🚀 Starting noVNC + VNC + Chrome"

# Kill any old display
pkill Xvfb 2>/dev/null
pkill x11vnc 2>/dev/null

# Start virtual display
Xvfb :1 -screen 0 1280x720x16 &
export DISPLAY=:1

# Start lightweight window manager
fluxbox &

# Start VNC server
x11vnc -display :1 -forever -shared -rfbport 5901 -passwd 1234 -nopw -bg

# Get noVNC (only if not present)
if [ ! -d "/root/noVNC" ]; then
  git clone https://github.com/novnc/noVNC.git /root/noVNC --depth=1
  git clone https://github.com/novnc/websockify.git /root/noVNC/utils/websockify --depth=1
fi

# Enable auto-connect HTML
cd /root/noVNC
cat <<EOF > /root/noVNC/vnc_auto.html
<!DOCTYPE html>
<html>
  <head><title>noVNC AutoConnect</title>
    <meta charset="utf-8"/>
    <script src="app/ui.js"></script>
  </head>
  <body>
    <script>
      window.location.href = "vnc.html?host=" + window.location.hostname + "&port=6080&autoconnect=true&password=1234";
    </script>
  </body>
</html>
EOF

# Launch Chrome
chromium-browser --no-sandbox --disable-gpu --disable-dev-shm-usage --start-maximized &

# Start noVNC
echo "✅ noVNC is live on port 6080"
echo "🌐 Open https://<your-app-name>.onrender.com/vnc_auto.html"
cd /root/noVNC
./utils/novnc_proxy --vnc localhost:5901 --listen 6080
