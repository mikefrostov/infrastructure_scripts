#!/bin/bash
set -e 

yum group install -y "Development Tools"
yum -y install qemu-kvm libvirt virt-install libvirt-devel  libxslt-devel libxml2-devel libvirt-devel libguestfs-tools-c
dnf install https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.rpm -y
#rpm -Uvh vagrant_2.2.4_x86_64.rpm
CONFIGURE_ARGS="with-libvirt-include=/usr/include/libvirt with-libvirt-lib=/usr/lib64" vagrant plugin install vagrant-libvirt
echo 'export VAGRANT_HOME=/home/VMs/vagrant' >> /etc/profile
