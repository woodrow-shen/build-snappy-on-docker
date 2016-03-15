# The Dockerfile setup Ubuntu 15.04 and Snappy environment in order to build a image
# Author: Woodrow Shen <woodrow.shen@canonical.com>

# Pull base image.
FROM ubuntu:16.04

MAINTAINER woodrowshen woodrow.shen@canonical.com

# Add multiverse to sourcelist
RUN echo "deb http://archive.ubuntu.com/ubuntu xenial multiverse" >> /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu xenial-updates multiverse" >> /etc/apt/sources.list

# Install necessary packages.
RUN \
	apt-get update && \
	apt-get install -y software-properties-common && \
	apt-get install -y curl git htop man unzip vim wget && \
	apt-get update && \
	apt-get install -y grub-common kmod kvm ovmf && \
	apt-get install -y sudo cpio && \
	apt-get install -y ubuntu-device-flash ubuntu-snappy squashfs-tools && \
	mv /sbin/udevadm /sbin/udevadm.ori && \
	wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key |  apt-key add - && \
	sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list' && \
	apt-get update && \
	apt-get install -y jenkins
	
# Add files.
ADD udevadm.wrapper /sbin/udevadm
ADD OVMF.fd /test/
ADD startup.sh /

# Define default command.
CMD ["/startup.sh"]
