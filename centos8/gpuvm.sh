
virt-install \
--name centos8 \
--ram 8192 \
--disk path=/var/kvm/images/centos8.img,size=30 \
--vcpus 4 \
--os-type linux \
--os-variant rhel8.0 \
--network bridge=br0 \
--graphics none \
--console pty,target_type=serial \
--location 'https://ftp.riken.jp/Linux/centos/8/BaseOS/x86_64/os/' \
--extra-args 'console=ttyS0,115200n8 serial' \
--host-device 07:00.0 \
--host-device 07:00.1 \
--features kvm_hidden=on \
--machine q35 \
--boot uefi
