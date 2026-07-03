# Base image for our automation environment
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install SSH tools needed for Ansible to connect to routers
RUN apt-get update && apt-get install -y openssh-client sshpass
