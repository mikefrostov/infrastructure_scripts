#!/bin/bash
set -e 

yum group install -y "Development Tools"
yum -y install qemu-kvm libvirt virt-install libvirt-devel  libxslt-devel libxml2-devel libvirt-devel libguestfs-tools-c
dnf install https://releases.hashicorp.com/vagrant/2.2.10/vagrant_2.2.10_x86_64.rpm -y
#rpm -Uvh vagrant_2.2.4_x86_64.rpm
CONFIGURE_ARGS="with-libvirt-include=/usr/include/libvirt with-libvirt-lib=/usr/lib64" vagrant plugin install vagrant-libvirt
echo 'export VAGRANT_HOME=/home/VMs/vagrant' >> /etc/profile
#dnf install python3 -y
#dnf install python3-pip -y
dnf -y install ansible
#pip3 install ansible 
ansible --version
