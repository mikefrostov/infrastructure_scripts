# infrastructure_scripts

Here lies... a quick way to setup home DevOps infrastructure. 

## ansible folder
Contains 
- hypervisor.yml playbook to install kvm+libvirt to a centos7 host and configure br0 bridge 
- kube-cluster folder with playbooks that setup and configure 3 hosts with IPs 192.168.1.151..153 into a cluster

## centos7 folder

Contains bash scripts that install what their names say and a folder pxe_tftpd

### pxe_tftpd_install.sh
#1 install.sh
1) Install dnsmasq, ftp, tftp, tftpboot, syslinux
2) Create pxelinux.cfg
3) Configure dnsmasq dhcp server to point to tftpboot pxelinux
4) Download Centos 7 minimal ISO
5) Mount ISO and copy files to ftp folder
6) Move configs and other files to their paths
