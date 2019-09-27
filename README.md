# infrastructure_scripts
Bash scripts, ansible playbooks and Vagranfile to setup various DevOps tools. 

## ansible folder
### centos7
Contains 
- hypervisor.yml playbook that installs kvm+libvirt to a centos7 host and configures br0 bridge 
- kube-cluster folder with playbooks that setup and configure 3 hosts (vms) with IPs 192.168.1.151..153 into a kubernetes cluster. YOU should have copied ssh keys to these hosts previously to runnig these playbooks (DUH).

### ubuntu playbooks might be added later
<later>

## centos7 folder

Contains bash installation scripts for tools and a pxe_tftpd folder:

### pxe_tftpd_install.sh
1) Installs dnsmasq, ftp, tftp, tftpboot, syslinux
2) Creates pxelinux.cfg
3) Configures dnsmasq dhcp server that points to PXEconfig machines that are booting PXE(Netinst)
4) Downloads Centos 7 minimal ISO
5) Mounts ISO and copies files to ftp folder and vmlinuz/initram images to tftp so that PXE(Netinst) machines could get initram
6) Moves configs and other stuff
7) Reboots the machine so that network configs are applied on boot

### pxevm.sh 
Creates a libvirt virtual machine that tries to boot using PXE first. Good for checking that pxe_tftpd stuff works properly

### centos7vm.sh
Just creates a libvirt virtual machine that plugs in an ISO image in order to install the OS

## docker
Dockerfiles and configs for tools that I run in my environment

## ubuntu18
Tools installation scripts.


## vagrant
Vagrant files and ansible provisioning files that bring up kubernetes, elk inside kvm.


