virt-install \
--virt-type=kvm \
--name pxevm \
--ram 2048 \
--vcpus=1 \
--os-variant=centos7.0 \
--network=bridge=enp2s0,model=e1000 \
--graphics vnc,listen=0.0.0.0 --noautoconsole \
--cdrom /storage/CentOS-7-x86_64-Minimal-1908.iso \
--disk path=/storage/pxevm.qcow2,size=40,bus=ide,format=qcow2
