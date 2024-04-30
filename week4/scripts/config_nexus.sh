#!/bin/bash
useradd -m -s /bin/bash demouser
chown -R demouser:demouser /home/demouser
echo 'demouser:changeme' | chpasswd
echo 'demouser ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/demouser
echo 'PasswordAuthentication yes' > /etc/ssh/sshd_config.d/00-PasswordAuthentication.conf
systemctl restart sshd.service
hostnamectl set-hostname nexus
echo 'nexus' > /proc/sys/kernel/hostname

# Update the system
apt-get update -y
apt-get upgrade -y

# Add Docker's official GPG key:
apt-get install ca-certificates curl -y
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y

# install the latest docker version
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# add ubuntu user to docker group
usermod -aG docker ubuntu

# Create a directory for Nexus and Docker Compose file
mkdir -p /srv/nexus
cat <<'EOF' >/srv/nexus/docker-compose.yml
services:
  nexus:
    image: sonatype/nexus3:latest
    container_name: nexus
    restart: always
    ports:
      - "8081:8081"
    volumes:
      - nexus-data:/nexus-data

volumes:
  nexus-data:
EOF

# Navigate to the Nexus directory and start the Nexus container
cd /srv/nexus
docker compose up -d