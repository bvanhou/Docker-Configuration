#!/bin/bash

yum -y update && sudo yum install -y vim && sudo yum install -y git

sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

yum install -y docker-engine
systemctl enable docker.service
systemctl start docker
yum install -y epel-release
yum -y install python-pip
pip install docker-compose


#Update Yum Package Manager
yum update -y

#Install Docker
yum install docker -y

#Start the Docker Service
service docker start

#Add the ec2-user to the docker group so you can execute Docker commands without using sudo.
usermod -a -G docker admin
