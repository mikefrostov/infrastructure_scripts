# infrastructure_scripts
Bash scripts that quickly set up my frastructure
Prereqs:
a) should have dhcp configured on a network that gives your Centos7 minimal box a GW and an IP/mask
b) You should run this on Centos7minimal or higher
What it does:
#1 install.sh
1) Install dnsmasq, ftp, tftp, tftpboot, syslinux
2) Create pxelinux.cfg
3) Configure dnsmasq dhcp server to point to tftpboot pxelinux
4) Download Centos 7 minimal ISO
5) Mount ISO and copy files to ftp folder
6) Move configs and other files to their paths

#2 kvm.sh
1) Install KVM
2) Configure KVM
 - check that br0 exists, if not - create
3) Install KVM centos 7 with a kickstart through a pxe installation

#3 win.sh (not ready yet)
1) downloads WinPE files for win7 winXP winserver2016 win10 in order to use them for pxe boot from my public FTP server
2) downloads Windows ISOs from my public ftp server
3) creates samba share
4) puts Windows ISO files to the samba share 
