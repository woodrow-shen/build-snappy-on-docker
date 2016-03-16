#!/bin/bash

set -e

# Fix sudo: no tty present and no askpass program specified
chmod +w /etc/sudoers
echo '%jenkins ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
chmod -w /etc/sudoers

