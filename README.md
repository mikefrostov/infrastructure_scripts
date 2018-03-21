# infrastructure_scripts
Bash scripts that quickly set up my frastructure
#1
1) Install dnsmasq, ftp, tftp, tftpboot, syslinux
2) Create pxelinux.cfg
3) Configure dnsmasq dhcp server to point to tftpboot pxelinux 
4) Download Centos 7 minimal ISO 
5) Mount ISO and copy files to ftp folder
6) Move configs and other files to their paths

#2
1) Install KVM 
2) Configure KVM 
 - check that br0 exists, if not - create 
3) Install KVM centos 7 with a kickstart through a pxe installation
