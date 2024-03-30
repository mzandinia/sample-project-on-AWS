#!/bin/bash
useradd -m -s /bin/bash demouser
chown -R demouser:demouser /home/demouser
echo 'demouser:changeme' | chpasswd
echo 'demouser ALL=(ALL) NOPASSWD: ALL' | sudo tee /etc/sudoers.d/demouser
echo 'PasswordAuthentication yes' > /etc/ssh/sshd_config.d/00-PasswordAuthentication.conf
systemctl restart sshd.service

