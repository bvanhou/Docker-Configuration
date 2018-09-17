# Docker-Configuration
### Installation within CentOS
###### ==========================
##### Basic Directory Tree Schema 
```
/data
|-- certs
|-- sites
|   |-- dev_snmp6
|   |-- netfilter
|-- ngnix
|   |-- vhost.d
```

###### To Utilize scripts perform as root

```
yum -y update && sudo yum install -y vim && sudo yum install -y git
```

```
sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF
```
```
yum install -y docker-engine
systemctl enable docker.service
systemctl start docker
yum install -y epel-release
yum -y install python-pip
pip install docker-compose
```
### Configure Firewall Rules
###### =====================================
```
firewall-cmd --permanent --zone=public --add-port=2376/tcp
firewall-cmd --reload
 
# check rules
firewall-cmd --list-all
```


### Install Docker 
###### =====================================
Update the packages on your instance
```
#Update Yum Package Manager
yum update -y

#Install Docker
yum install docker -y

#Start the Docker Service
service docker start

#Add the ec2-user to the docker group so you can execute Docker commands without using sudo.
usermod -a -G docker <user>
```




### End Docker-Compose and Docker Clean-up 
###### ======================================
```
sudo docker-compose stop && sudo docker-compose rm -f
docker rmi $(docker images -q -f dangling=true)
docker rm -v $(docker ps -a -q -f status=exited)
```

### Start Docker-Compose and Docker build image
###### ======================================
```
docker-compose build && docker-compose up -d
```


### List all containers (only IDs)
###### ======================================
```
docker ps -aq
```

### Stop all running containers
###### ======================================
```
docker stop $(docker ps -aq)
```

### Remove all containers
###### ======================================
```
docker rm $(docker ps -aq)
```

### Remove all images
###### ======================================
```
docker rmi $(docker images -q)
```

### Resolve Ansible Issue: Cannot have both the docker-py and docker python modules installed
###### ======================================
First uninstall everything docker related in the virtualenv for Ansible.
```pip uninstall docker docker-py docker-compose```
And then install the docker-compose module, which will install the docker module as well as a dependency.
```pip install docker-compose```

The Ansible docker module will try to import docker, which will also succeed with the docker module, and as such not provide an error with the misleading instruction to install docker-py.
