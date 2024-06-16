# Use the official Ubuntu image as a base
FROM ubuntu:latest

# Install necessary packages including openssh-server and systemd
RUN apt-get update && \
    apt-get install -y sudo curl wget git build-essential software-properties-common openssh-server systemd dbus && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure SSH server
RUN mkdir /var/run/sshd && \
    echo 'root:password' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config && \
    mkdir -p /root/.ssh && chmod 700 /root/.ssh

# Enable SSH service to start on boot
RUN systemctl enable ssh

# Expose SSH port
EXPOSE 2222

# Set up a non-root user (optional)
RUN useradd -ms /bin/bash devuser && echo 'devuser:password' | chpasswd && adduser devuser sudo

# Install Docker
RUN curl -fsSL https://get.docker.com | sh

# Ensure Docker starts on boot
RUN systemctl enable docker

# Copy the startup script
COPY start_services.sh /usr/local/bin/start_services.sh

# Ensure the script is executable
RUN chmod +x /usr/local/bin/start_services.sh

# Start services and keep the container running
CMD ["/usr/local/bin/start_services.sh"]
