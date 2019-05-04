#!/bin/bash
set -e 
echo 'run with sudo plz' 
apt-get install qemu-kvm libvirt-bin virtinst bridge-utils cpu-checker -y 
kvm-ok
sudo cp /etc/network/interfaces /etc/network/interfaces.bk
sudo rm -f /etc/network/interfaces
ownif=$(route | grep '^default' | grep -o '[^ ]*$')
echo ' auto br0
 iface br0 inet static
         address 10.18.44.26
         netmask 255.255.255.192
         broadcast 10.18.44.63
         dns-nameservers 10.0.80.11 10.0.80.12
         # set static route for LAN
 	 post-up route add -net 10.0.0.0 netmask 255.0.0.0 gw 10.18.44.1
 	 post-up route add -net 161.26.0.0 netmask 255.255.0.0 gw 10.18.44.1
         bridge_ports eth0
         bridge_stp off
         bridge_fd 0
         bridge_maxwait 0
 
 # br1 setup with static wan IPv4 with ISP router as a default gateway
 auto br1
 iface br1 inet static
         address 208.43.222.51
         netmask 255.255.255.248
         broadcast 208.43.222.55
         gateway 208.43.222.49
         bridge_ports eth1
         bridge_stp off
         bridge_fd 0
         bridge_maxwait 0' >> /etc/network/interfaces
sudo systemctl restart networking
sudo brctl show
cd /var/lib/libvirt/boot/
sudo wget https://mirrors.kernel.org/centos/7/isos/x86_64/CentOS-7-x86_64-DVD-1708.iso
sudo virt-install \
--virt-type=kvm \
--name centos7 \
--ram 2048 \
--vcpus=2 \
--os-variant=centos7.0 \
--virt-type=kvm \
--hvm \
--cdrom=/var/lib/libvirt/boot/CentOS-7-x86_64-DVD-1708.iso \
--network=bridge=br0,model=virtio \
--network=bridge=br1,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/centos7.qcow2,size=40,bus=virtio,format=qcow2


