FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV USER=root

# Install only what we need
RUN apt update && apt install -y \
    xvfb x11vnc fluxbox novnc websockify tightvncserver chromium-browser git curl wget \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Set VNC password
RUN mkdir -p /root/.vnc && \
    echo "1234" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

# Copy and allow start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080
CMD ["/start.sh"]
