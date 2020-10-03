sudo virt-install \
--name win \
--ram 8192 \
--disk path=/home/wingpu.qcow2,size=20 \
--vcpus 4 \
--os-type=windows \
--os-variant=win10 \
--network bridge=virbr0 \
--graphics vnc,listen=0.0.0.0,port=5901 --noautoconsole \
--cdrom /home/virtio-win.iso \
--cdrom /home/win10.iso \
--hostdev 07:00.0 \
--hostdev 07:00.1

