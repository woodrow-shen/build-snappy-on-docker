# The Dockerfile setup Ubuntu 15.04 and Snappy environment in order to build a image
# Author: Woodrow Shen <woodrow.shen@canonical.com>

# Pull base image.
FROM ubuntu:15.04

MAINTAINER woodrowshen woodrow.shen@canonical.com

# Install necessary packages.
RUN \
	apt-get update && \
	apt-get install -y software-properties-common && \
	apt-get install -y build-essential && \
	apt-get install -y curl git htop man unzip vim wget && \
	add-apt-repository -y ppa:snappy-dev/tools && \
	apt-get update && \
	apt-get install ubuntu-device-flash snappy-tools squashfs-tools && \
	ssh-keygen -t rsa && \
	useradd -r -s /bin/false -d /nonexistent -U clickpkg && \
	useradd -r -s /bin/false -d /nonexistent -U snappypkg && \
	mv /sbin/udevadm /sbin/udevadm.ori && \
	wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key |  apt-key add - && \
	sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list' && \
	apt-get update && \
	apt-get install jenkins
	
# Add files.
ADD udevadm.sh /sbin/udevadm

# Define default command.
CMD ["bash"]

