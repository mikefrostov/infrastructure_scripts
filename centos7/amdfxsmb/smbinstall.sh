#!/bin/bash
set -e

#samba install and configure
yum install samba samba-client samba-common -y
yum install ntfs-3g -y
firewall-cmd --permanent --zone=public --add-service=samba
firewall-cmd --reload
cp /etc/samba/smb.conf /etc/samba/smb.conf.orig
cat /dev/null > /etc/samba/smb.conf
cp ./smb.conf /etc/samba/smb.conf
mkdir /mnt/2tb
mkdir /mnt/4tb
mkdir /mnt/4tb2
lsblk -l
mount /dev/sda1 /mnt/4tb/
mount /dev/sde1 /mnt/2tb/
mount /dev/sdd2 /mnt/4tb2/
sytemctl status smb
systemctl status nmb
chcon -t samba_share_t /mnt/2tb/
chmod -R 0755 /mnt/2tb/
chown -R nobody:nobody /mnt/2tb/
chcon -t samba_share_t /mnt/4tb/
chmod -R 0755 /mnt/4tb/
chown -R nobody:nobody /mnt/4tb/
chcon -t samba_share_t /mnt/4tb2/
chmod -R 0755 /mnt/4tb2/
chown -R nobody:nobody /mnt/4tb2/ 
systemctl enable smb.service
systemctl enable nmb.service
systemctl restart smb.service
systemctl restart nmb.service
#  vi /etc/fstab
# echo '/dev/sda1 /mnt/2tb default 0 0 0 >> /etc/fstab
#chcon -R -t samba_share_t /mnt/2tb # -t??

sestatus
setenforce 0
sed -i -e 's/enforcing/permissive/g' /etc/selinux/config
reboot
yum install vsftpd -y
systemctl enable vsftpd
firewall-cmd --zone=public --permanent --add-port=21/tcp
firewall-cmd --zone=public --permanent --add-service=ftp
firewall-cmd –-reload
firewall-cmd --reload
sudo cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.default
#vi /etc/vsftpd/vsftpd.conf
systemctl restart vsftpd
systemctl status vsftpd
mkdir -p /var/ftp/pub
chown nobody:nogroup /var/ftp/pub
chown nobody:nobody /var/ftp/pub
echo "vsftpd test file" | sudo tee /var/ftp/pub/test.txt
ls /var/ftp/pub/
#vi /etc/vsftpd.conf
#vi /etc/vsftpd/vsftpd.conf
systemctl status vsftpd
systemctl restart vsftpd
systemctl status vsftpd
#mount --bind /mnt/2tb/share/biblioteka/mylib/computer\ science/devops/virtual.cloud/Microsoft/ /var/ftp/pub/
#umount /var/ftp/pub/
