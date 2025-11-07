FROM ubuntu:22.04

# install required packages
RUN apt update && apt install -y \
    xfce4 xfce4-goodies tightvncserver novnc websockify python3-numpy curl git && \
    apt clean

# set password for VNC
RUN mkdir -p /root/.vnc && \
    echo "1234" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

# copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# expose noVNC port
EXPOSE 6080

CMD ["/start.sh"]
