#!/bin/bash
set -e 
echo 'run with sudo plz' 
apt-get install qemu-kvm libvirt-bin virtinst bridge-utils cpu-checker -y 
kvm-ok
sudo cp /etc/network/interfaces /etc/network/interfaces.bk
sudo rm -f /etc/network/interfaces
ownif=$(route | grep '^default' | grep -o '[^ ]*$')
sudo brctl addbr br0
sudo brclt addif br0 $ownif
echo ' auto lo br0
 iface lo inet loopback
 iface br0 inet dhcp
 bridge_ports $ownif ' >> /etc/network/interfaces
sudo systemctl restart networking
sudo brctl show
mkdir -p  /var/lib/libvirt/images/
cd /var/lib/libvirt/images/
sudo wget http://mirror.corbina.net/pub/Linux/centos/7.6.1810/isos/x86_64/CentOS-7-x86_64-Minimal-1810.iso
sudo virt-install \
--virt-type=kvm \
--name centos7 \
--ram 2048 \
--vcpus=2 \
--os-variant=centos7.0 \
--virt-type=kvm \
--hvm \
--cdrom=/var/lib/libvirt/images/CentOS-7-x86_64-Minimal-1810.iso \
--network=bridge=br0,model=virtio \
--graphics vnc, listen=0.0.0.0 --noautoconsole \
--disk path=/var/lib/libvirt/images/centos7.qcow2,size=40,bus=virtio,format=qcow2


