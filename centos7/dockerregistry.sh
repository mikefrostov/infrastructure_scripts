#!/bin/bash
set -e 

yum -y install docker-distribution
firewall-cmd --add-port=5000/tcp --permanent
firewall-cmd --reload
systemctl start docker-distribution
systemctl enable docker-distribution
systemctl status docker-distribution

