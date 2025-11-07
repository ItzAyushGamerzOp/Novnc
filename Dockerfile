FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV USER=root

# Install only necessary packages
RUN apt update && apt install -y \
    xvfb x11vnc fluxbox novnc websockify chromium-browser curl git wget \
    && apt clean && rm -rf /var/lib/apt/lists/*

# VNC password (auto login)
RUN mkdir -p /root/.vnc && \
    echo "1234" | vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080
CMD ["/start.sh"]
