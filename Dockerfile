FROM ubuntu:22.04

# disable tzdata prompt
ENV DEBIAN_FRONTEND=noninteractive

# Update system & install packages
RUN apt update && apt install -y \
    novnc websockify xfce4 xfce4-goodies tightvncserver xterm wget curl net-tools \
    && apt clean

# Set environment variables
ENV USER root
ENV DISPLAY :1
ENV VNC_PORT 5901
ENV NOVNC_PORT 6080

# Setup VNC password (blank by default)
RUN mkdir /root/.vnc && \
    echo "1234" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080
CMD ["/start.sh"]
