#!/bin/bash
yum install qemu-kvm libvirt libvirt-python libguestfs-tools virt-install -y
systemctl enable libvirtd
systemctl start libvirtd
ownif=$(route | grep '^default' | grep -o '[^ ]*$')
## need to implement check that brX already exists and add br(X+1)
echo "BRIDGE=br0" >> /etc/sysconfig/network-scripts/ifcfg-$ownif
echo "DEVICE="br0" \
# I am getting ip from DHCP server # \
BOOTPROTO="dhcp" \
IPV6INIT="yes" \
IPV6_AUTOCONF="yes" \
ONBOOT="yes" \
TYPE="Bridge" \
DELAY="0" " >> /etc/sysconfig/network-scripts/ifcfg-br0
systemctl restart NetworkManager 
systemctl restart network 
##check and verify that no errors, continue

echo "virt-install \
--virt-type=kvm \
--name centos7-2 \
--ram 2048 \
--vcpus=1 \
--os-variant=centos7.0 \
--cdrom=./CentOS-7-x86_64-Minimal-1708.iso \
--network=bridge=br0,model=virtio \
--graphics vnc \
--disk path=./centos7-2.qcow2,size=40,bus=virtio,format=qcow2" >> ./centos7.sh
chmod +x ./centos7.sh
./centos7.sh

