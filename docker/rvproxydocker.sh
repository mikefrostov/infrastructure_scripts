#!/bin/bash
set -e
hostnamectl set-hostname docker.vm 
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce
docker pull centos
systemctl enable dockerd
systemctl enable docker
systemctl start docker
docker pull centos
mkdir app
cd app
#touch package.json <--------
#package.json  <------
yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash -
yum install -y nodejs
npm install
#touch server.js <-----
#vi server.js <--------
#touch Dockerfile
#vi Dockerfile
#docker build -t mikefrostov/node-app .
docker images
#systemctl stop firewalld
docker run -p 49160:8080 -d mikefrostov/node-app:latest
#systemctl start firewalld
#docker run -p 49160:8080 -d mikefrostov/node-app:latest
#docker ps
#docker logs 0a53fc9f4dc4
#firewall-cmd --zone=public --permanent --add-port=8080/tcp
#firewall-cmd --reload
#docker ps
#firewall-cmd --permanent --zone=trusted --change-interface=docker0
#firewall-cmd --permanent --zone=trusted --add-port=4243/tcp
#firewall-cmd --reload
#systemctl restart docker
#firewall-cmd --permanent --zone=trusted --add-port=8080/tcp
#reboot
#docker ps
#docker images --all
#docker run -p 49160:8080 -d mikefrostov/node-app

