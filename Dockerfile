FROM kalilinux/kali-rolling

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get -y install openssh-server sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configure SSH
RUN mkdir -p /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    echo "Port 22" >> /etc/ssh/sshd_config && \
    echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config

# Create startup script to set up user and start SSH
RUN printf '#!/bin/bash\n\
if [ -n "$USERNAME" ] && [ -n "$PASSWORD" ]; then\n\
    if id "$USERNAME" &>/dev/null; then\n\
        echo "$USERNAME:$PASSWORD" | chpasswd\n\
    else\n\
        useradd -m -s /bin/bash "$USERNAME" && echo "$USERNAME:$PASSWORD" | chpasswd\n\
        usermod -aG sudo "$USERNAME"\n\
        echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers\n\
    fi\n\
fi\n\
/usr/sbin/sshd -D\n' > /start.sh && chmod +x /start.sh

EXPOSE 22

CMD ["/start.sh"]
