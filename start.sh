#!/bin/bash
# Start VNC server
vncserver :1 -geometry 1280x800 -depth 24

# Start noVNC
websockify --web=/usr/share/novnc/ 6080 localhost:5901 &
echo "noVNC running on port 6080"

# Keep container alive
tail -f /dev/null
