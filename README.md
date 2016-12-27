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
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
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


# End Docker-Compose and Docker Clean-up
# ======================================
sudo docker-compose stop && sudo docker-compose rm -f
docker rmi $(docker images -q -f dangling=true)
docker rm -v $(docker ps -a -q -f status=exited)
