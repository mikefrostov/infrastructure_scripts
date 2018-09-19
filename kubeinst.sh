#!/bin/bash
set -e

#The Kubernetes package provides a few services:
# kube-apiserver,
# kube-scheduler,
# kube-controller-manager,
# kubelet,
# kube-proxy.

# Hostnames should be same accross the Kubernetes cluster. Hav ethe following in /etc/hosts 
# on all hosts of the cluster. (You can use IP of your choice - ofcourse!).

#ex
# 127.0.0.1 localhost localhost.localdomain
# 192.168.124.30 centos-master
# 192.168.124.31 centos-minion

echo "192.168.1.90 kubernetes.vm" >> /etc/hosts
echo "192.168.1.91 kubernetes2.vm" >> /etc/hosts
echo "192.168.1.92 kubernetes3.vm" >> /etc/hosts

systemctl disable iptables-services firewalld
systemctl stop iptables-services firewalld

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF
setenforce 0
yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
systemctl enable kubelet && systemctl start kubelet
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

