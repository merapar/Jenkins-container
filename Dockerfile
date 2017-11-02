# vim: ft=dockerfile
###############################################################################
# Jenkins with DooD (Docker outside of Docker)
# http://github.com/merapar/docker-jenkins
# Author: Dennis Bell <dennis.bell@merapar.com>
# Based on:
# * http://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci
###############################################################################

FROM jenkins/jenkins:2.87
MAINTAINER Dennis Bell <dennis.bell@merapar.com>

# Install necessary packages
USER root
RUN apt-get update \
      && apt-get install -y sudo python-pip \
      && rm -rf /var/lib/apt/lists/*

# Install docker-engine
# We will bind the socket to use the host docker engine from the container

ARG docker_version=17.06.1~ce-0~debian

RUN curl -sSL https://get.docker.com/ | \
  sed "s/docker-ce/docker-ce=${docker_version}/" | sh

# Make sure jenkins user has docker privileges to use the socket
RUN usermod -aG docker jenkins

# Make sure jenkins scripts can run sudo
RUN echo 'jenkins ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Install initial plugins
USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
ENV JENKINS_UC="https://updates.jenkins.io"
RUN /usr/local/bin/install-plugins.sh /usr/share/jenkins/plugins.txt
