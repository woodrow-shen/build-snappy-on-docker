# The Dockerfile setup Ubuntu 15.04 and Snappy environment in order to build a image
# Author: Woodrow Shen <woodrow.shen@canonical.com>

# Pull base image.
FROM ubuntu:15.04

MAINTAINER woodrowshen woodrow.shen@canonical.com

# Install necessary packages.
RUN \
	apt-get update && \
	apt-get install -y software-properties-common && \
	apt-get install -y curl git htop man unzip vim wget sudo && \
	add-apt-repository -y ppa:snappy-dev/tools && \
	apt-get update && \
	apt-get install -y grub-common kmod && \
	apt-get install -y ubuntu-device-flash snappy-tools squashfs-tools && \
	mv /sbin/udevadm /sbin/udevadm.ori && \
	wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key |  apt-key add - && \
	sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list' && \
	apt-get update && \
	apt-get install -y jenkins && \
	
# Add files.
ADD udevadm.sh /sbin/udevadm

# Define default command.
CMD ["bash"]

