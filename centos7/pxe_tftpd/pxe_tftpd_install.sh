#!/bin/bash
## need to implement checks that it is Centos 7 distro indeed
set -e


#1) dnsmasq installation and configuration
yum install dnsmasq net-tools -y
ownip=$(hostname -I)
ownif=$(route | grep '^default' | grep -o '[^ ]*$')
GW=$(/sbin/ip route | awk '/default/ { print $3 }')

mv /etc/dnsmasq.conf  /etc/dnsmasq.conf.backup

#generate dnsmasq.conf

echo "interface=$ownif" >> /etc/dnsmasq.conf
echo "#bind-interfaces" >> /etc/dnsmasq.conf
echo "domain=pxe.lan" >> /etc/dnsmasq.conf
echo "# DHCP range-leases" >> /etc/dnsmasq.conf
echo "dhcp-range= $ownif, 192.168.1.200,192.168.1.240,255.255.255.0,1h" >> /etc/dnsmasq.conf ## change pool into generated
echo "# PXE" >> /etc/dnsmasq.conf
echo "dhcp-boot=pxelinux.0,pxeserver,$ownip" >> /etc/dnsmasq.conf
echo "# Gateway" >> /etc/dnsmasq.conf
echo "dhcp-option=3,$GW" >> /etc/dnsmasq.conf
echo "pxe-service=x86PC, "Install from network server", pxelinux" >> /etc/dnsmasq.conf
echo "enable-tftp" >> /etc/dnsmasq.conf
echo "tftp-root=/var/lib/tftpboot" >> /etc/dnsmasq.conf


yum install syslinux -y
yum install tftp-server -y
cp -r /usr/share/syslinux/* /var/lib/tftpboot
mkdir /var/lib/tftpboot/pxelinux.cfg


echo "default menu.c32
prompt 0
timeout 100
ONTIMEOUT bootlocal
menu title ########## PXE Boot Menu ##########
label bootlocal
menu label ^1) Boot from local drive
localboot 0
label 2
menu label ^2) Install CentOS 7 x64 with Local Repo
kernel centos7/vmlinuz
append initrd=centos7/initrd.img method=ftp://$ownip/pub/centos7/ devfs=nomount" >> /var/lib/tftpboot/pxelinux.cfg/default
echo "label 3
menu label ^3) Install CentOS 7 x64 with http://mirror.centos.org Repo
kernel centos7/vmlinuz
append initrd=centos7/initrd.img method=http://mirror.centos.org/centos/7/os/x86_64/ devfs=nomount ip=dhcp
label 4
menu label ^4) Install CentOS 7 x64 with Local Repo using VNC
kernel centos7/vmlinuz
append  initrd=centos7/initrd.img method=ftp://$ownip/pub/centos7/ devfs=nomount
label 5
menu label ^5) Install CentOS 7 x64 with Local Repo using Kickstart
kernel centos7/vmlinuz
append initrd=centos7/initrd.img inst.ks=ftp://$ownip/pub/centos7/anaconda-ks.cfg
label 6
menu label ^6) Install ubuntu 16-04 x64
kernel ubuntu-installer/amd64/linux
append vga=788 initrd=ubuntu-installer/amd64/initrd.gz -- quiet
label 7
menu label ^7) Install Windows 8.1 x64
KERNEL memdisk
INITRD windows/win8pe_amd64.iso
APPEND iso raw
label 8
menu label ^8) Install Windows 7 x64
KERNEL memdisk
INITRD windows/win7pe_amd64.iso
APPEND iso raw
label 9
menu label ^9) Install Windows 7 x32
KERNEL memdisk
INITRD windows/win7pe_x86.iso
APPEND iso raw
label 10
menu label ^10) Install Windows 10 x64 1607
KERNEL memdisk
INITRD windows/Win101607PE_amd64.iso
APPEND iso raw" >> /var/lib/tftpboot/pxelinux.cfg/default
yum install wget -y
cd 
wget http://mirror.yandex.ru/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1908.iso
mount -o loop ./CentOS-7-x86_64-Minimal-1810.iso /mnt/
mkdir -p /var/lib/tftpboot/centos7
mkdir -p /var/ftp/pub/centos7/
cp /mnt/images/pxeboot/vmlinuz  /var/lib/tftpboot/centos7/
cp /mnt/images/pxeboot/initrd.img  /var/lib/tftpboot/centos7/
yum install vsftpd -y
cp -r /mnt/*  /var/ftp/pub/centos7/
chmod -R 755 /var/ftp/pub/centos7/
systemctl start dnsmasq
systemctl start vsftpd
systemctl enable dnsmasq
systemctl enable vsftpd

#handling firewall rules
firewall-cmd --add-service=ftp --permanent
firewall-cmd --add-service=dns --permanent  	## Port 53
firewall-cmd --add-service=dhcp --permanent  	## Port 67
firewall-cmd --add-port=69/udp --permanent  	## Port for TFTP
firewall-cmd --add-port=4011/udp --permanent  ## Port for ProxyDHCP
firewall-cmd --reload  ## Apply rules
firewall-cmd --zone=public --add-service=vnc-server
firewall-cmd --zone=public --list-services
umount /mnt

# downloading winPE files to their folders

#mkdir -p /var/lib/tftpboot/windows/
#cd /var/lib/tftpboot/windows/

