virt-install \
--virt-type=kvm \
--name ubuserv \
--ram 2048 \
--vcpus=1 \
--os-variant=centos7.0 \
--network=bridge=enp2s0,model=e1000 \
--graphics vnc,listen=0.0.0.0 --noautoconsole \
--cdrom /storage/ubuntu18.04.3.iso \
--disk path=/storage/ubuserv.qcow2,size=40,bus=ide,format=qcow2
