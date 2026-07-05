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

# Install Ansible and NETCONF dependencies
RUN pip install --no-cache-dir ansible ncclient paramiko

# Copy our project files into the container
COPY . /app

# Default command to keep container running
CMD ["/bin/bash"]
