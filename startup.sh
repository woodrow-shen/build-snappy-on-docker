#!/bin/bash

set -e

# SSH keys generation
su jenkins
ssh-keygen -t rsa -b 2048 -f /var/lib/jenkins/.ssh/id_rsa -N ""
exit

# Fix sudo: no tty present and no askpass program specified
chmod +w /etc/sudoers
echo '%jenkins ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
chmod -w /etc/sudoers

