# Docker-Configuration
# Installation within CentOS
# ==========================
# Basic Directory Tree Schema 
# /data
# ../certs
# ../sites
# ../nginx/
# ../../vhost.d

sudo yum -y update && sudo yum install -y vim && sudo yum install -y git

sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

sudo yum install -y docker-engine

sudo systemctl enable docker.service

sudo systemctl start docker

sudo yum install -y epel-release

sudo yum -y install python-pip

sudo pip install docker-compose


# Install Docker 
# =====================================
Update the packages on your instance

[ec2-user ~]$ sudo yum update -y
Install Docker

[ec2-user ~]$ sudo yum install docker -y
Start the Docker Service

[ec2-user ~]$ sudo service docker start
Add the ec2-user to the docker group so you can execute Docker commands without using sudo.

[ec2-user ~]$ sudo usermod -a -G docker ec2-user





# End Docker-Compose and Docker Clean-up
# ======================================
sudo docker-compose stop && sudo docker-compose rm -f
docker rmi $(docker images -q -f dangling=true)
docker rm -v $(docker ps -a -q -f status=exited)
