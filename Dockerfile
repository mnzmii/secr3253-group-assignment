# Base image for our automation environment
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install SSH tools and Linux system monitoring tools for the bash script
RUN apt-get update && apt-get install -y \
    openssh-client \
    sshpass \
    procps \
    util-linux

# Install Ansible and NETCONF dependencies (Including pylibssh for modern SSH support)
RUN pip install --no-cache-dir ansible ncclient paramiko ansible-pylibssh

# Configure SSH to allow legacy security algorithms for the Cisco CSR1000v
RUN mkdir -p /root/.ssh && \
    echo "Host *" > /root/.ssh/config && \
    echo "    KexAlgorithms +diffie-hellman-group14-sha1,diffie-hellman-group-exchange-sha1" >> /root/.ssh/config && \
    echo "    HostKeyAlgorithms +ssh-rsa" >> /root/.ssh/config && \
    echo "    PubkeyAcceptedKeyTypes +ssh-rsa" >> /root/.ssh/config && \
    chmod 600 /root/.ssh/config

# Copy our project files into the container
COPY . /app

# Default command to keep container running
CMD ["/bin/bash"]
