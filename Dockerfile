FROM ubuntu:22.04

# Install packages
RUN apt update && apt install -y \
    xfce4 xfce4-goodies tightvncserver novnc websockify python3-numpy wget curl && \
    apt clean

# Set up VNC password
RUN mkdir -p /root/.vnc && \
    echo "1234" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080
CMD ["/start.sh"]
