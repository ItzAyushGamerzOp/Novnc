FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=root
ENV DISPLAY=:1

# ✅ Install lightweight desktop & tools
RUN apt update && apt install -y \
    xfce4 xfce4-goodies tightvncserver novnc websockify \
    chromium-browser curl wget git xterm && \
    apt clean && rm -rf /var/lib/apt/lists/*

# ✅ Set VNC password (1234)
RUN mkdir -p /root/.vnc && \
    echo "1234" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

# ✅ Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080
CMD ["/start.sh"]
