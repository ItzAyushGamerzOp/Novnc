#!/bin/bash
echo "🚀 Starting noVNC + Chrome Desktop"

# Kill old sessions
pkill Xvfb 2>/dev/null
pkill x11vnc 2>/dev/null

# Start X virtual framebuffer
Xvfb :1 -screen 0 1280x720x16 &
export DISPLAY=:1

# Start minimal window manager
fluxbox &

# Start VNC server (reuses password)
x11vnc -display :1 -forever -shared -rfbport 5901 -passwdfile /root/.vnc/passwd -bg

# Clone noVNC if not found
if [ ! -d "/root/noVNC" ]; then
  git clone https://github.com/novnc/noVNC.git /root/noVNC --depth=1
  git clone https://github.com/novnc/websockify.git /root/noVNC/utils/websockify --depth=1
fi

# Auto-connect HTML
cat <<EOF > /root/noVNC/vnc_auto.html
<!DOCTYPE html>
<html>
  <head><title>noVNC AutoConnect</title>
    <meta charset="utf-8"/>
  </head>
  <body>
    <script>
      window.location.href = "vnc.html?host=" + window.location.hostname + "&port=6080&autoconnect=true&password=1234";
    </script>
  </body>
</html>
EOF

# Launch Chromium
chromium-browser --no-sandbox --disable-dev-shm-usage --disable-gpu --start-maximized &

# Start noVNC
cd /root/noVNC
echo "✅ noVNC running on port 6080"
echo "🌐 URL: https://<your-app>.onrender.com/vnc_auto.html"
./utils/novnc_proxy --vnc localhost:5901 --listen 6080
