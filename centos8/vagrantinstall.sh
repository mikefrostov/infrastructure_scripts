#!/bin/bash
set -e 

yum group install -y "Development Tools"
yum -y install qemu-kvm libvirt virt-install libvirt-devel  libxslt-devel libxml2-devel libvirt-devel libguestfs-tools-c
sudo dnf -y install rsync gcc zlib-devel libvirt-devel cmake
sudo dnf install -y ruby ruby-devel
sudo yum install -y yum-utils
yum install bison -y
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
#sudo dnf install gcc  libguestfs-tools-c libvirt libvirt-devel libxml2-devel libxslt-devel make ruby-devel -y

sudo yum install vagrant -y
#workaround #1
cd /tmp/ 
wget http://vault.centos.org/8.2.2004/BaseOS/Source/SPackages/krb5-1.17-18.el8.src.rpm
rpm2cpio krb5-1.17-18.el8.src.rpm | cpio -imdV
tar xf krb5-1.17.tar.gz
cd krb5-1.17/src
LDFLAGS='-L/opt/vagrant/embedded/' ./configure
make
pwd
sudo cp lib/libk5crypto.so.3 /opt/vagrant/embedded/lib64/
#workaround #2
ln -s /opt/vagrant/embedded/include/ruby-3.0.0/ruby/st.h /opt/vagrant/embedded/include/ruby-3.0.0/st.h
#workaround #3
dnf download --source libssh
rpm2cpio libssh-0.9.4-2.el8.src.rpm | cpio -imdV
tar xf libssh-0.9.4.tar.xz
mkdir build
cd build
cmake ../libssh-0.9.4 -DOPENSSL_ROOT_DIR=/opt/vagrant/embedded/
make
cp lib/libssh* /opt/vagrant/embedded/lib64

#CFLAGS="-I/opt/vagrant/embedded/include/ruby-3.0.0/ruby" CONFIGURE_ARGS="with-libvirt-include=/usr/include/libvirt with-libvirt-lib=/usr/lib64" vagrant plugin install vagrant-libvirt

vagrant plugin install vagrant-libvirt

echo 'export VAGRANT_HOME=/mnt/4tb2/images' >> /etc/profile
dnf install python3 -y
dnf install python3-pip -y
dnf -y install ansible
pip3 install ansible 
ansible --version
