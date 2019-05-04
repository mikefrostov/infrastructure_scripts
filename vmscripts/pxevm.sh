virt-install \
--virt-type=kvm \
--name pxevm \
--ram 8192 \
--vcpus=1 \
--os-variant=centos7.0 \
--network=bridge=br0,model=e1000 --pxe \
--graphics vnc,listen=0.0.0.0 --noautoconsole \
--disk path=/home/pxevm.qcow2,size=40,bus=ide,format=qcow2
