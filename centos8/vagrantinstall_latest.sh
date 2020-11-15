#!/bin/bash

#installation script with a workaround for latest centos8 

sudo dnf install gcc  libguestfs-tools-c libvirt libvirt-devel libxml2-devel libxslt-devel make ruby-devel
sudo dnf install https://releases.hashicorp.com/vagrant/2.2.10/vagrant_2.2.10_x86_64.rpm
cd /tmp/; wget http://vault.centos.org/8.2.2004/BaseOS/Source/SPackages/krb5-1.17-18.el8.src.rpm
rpm2cpio krb5-1.17-18.el8.src.rpm | cpio -imdV
tar xf krb5-1.17.tar.gz
cd krb5-1.17/src
LDFLAGS='-L/opt/vagrant/embedded/' ./configure
make
sudo cp lib/libk5crypto.so.3 /opt/vagrant/embedded/lib64/
vagrant plugin install vagrant-libvirt
