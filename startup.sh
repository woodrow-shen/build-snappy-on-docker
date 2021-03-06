#!/bin/bash

set -e

# install davfs2
apt-get install -y davfs2

# Fix sudo: no tty present and no askpass program specified
chmod +w /etc/sudoers
echo '%jenkins ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
chmod -w /etc/sudoers

# start jenkins
service jenkins start

exec /bin/bash
