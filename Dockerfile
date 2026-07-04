# Base image for our automation environment
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install SSH tools needed for Ansible to connect to routers
RUN apt-get update && apt-get install -y openssh-client sshpass

# Install Ansible and NETCONF dependencies
RUN pip install --no-cache-dir ansible ncclient paramiko

# Copy our project files into the container
COPY . /app
