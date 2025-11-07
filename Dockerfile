FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=root

# Install dependencies
RUN apt update && apt install -y \
    xfce4 xfce4-goodies tightvncserver git curl wget python3 python3-numpy novnc websockify && \
    apt clean

# Set VNC password
RUN mkdir -p /root/.vnc && \
    echo "1234" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080
CMD ["/start.sh"]
