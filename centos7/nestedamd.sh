cat /sys/module/kvm_amd/parameters/nested 
rmmod kvm-amd
echo 'options kvm-amd nested=1' >> /etc/modprobe.d/dist.conf
modprobe kvm-amd
cat /sys/module/kvm_amd/parameters/nested
