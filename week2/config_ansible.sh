#!/bin/bash
echo 'ubuntu:changeme' | chpasswd
echo 'ubuntu ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/ubuntu
echo 'PasswordAuthentication yes' > /etc/ssh/sshd_config.d/00-PasswordAuthentication.conf
systemctl restart sshd.service

# Update the system
apt-get update -y
apt-get upgrade -y

apt-get install -y git python3-pip sshpass
python3 -m pip install ansible
echo "# set PATH so it includes user's private bin if it exists" >> /root/.bashrc
echo """if [ -d "/root/.local/bin" ] ; then""" >> /root/.bashrc
echo """    PATH="/root/.local/bin:$PATH"""" >> /root/.bashrc
echo 'fi' >> /root/.bashrc