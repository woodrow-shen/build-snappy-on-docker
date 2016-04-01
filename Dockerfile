# The Dockerfile setup Ubuntu 16.04 and Snappy environment in order to build a image
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
	apt-get install -y sudo dpkg software-properties-common && \
	apt-get install -y curl git htop man unzip vim wget && \
	apt-get install -y grub-common kmod kvm ovmf udev davfs2 && \
	wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key |  apt-key add - && \
	sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list' && \
	apt-get update && \
	apt-get install -y jenkins && \
	apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat cpio && \
	apt-get install -y libsdl1.2-dev xterm && \
	apt-get install -y make xsltproc docbook-utils fop dblatex xmlto && \
	apt-get install -y autoconf automake libtool libglib2.0-dev && \
	apt-get install -y lib32stdc++6 && \
	apt-get install -y imagemagick

# Add files.
ADD startup.sh /

# Define default command.
CMD ["/startup.sh"]
