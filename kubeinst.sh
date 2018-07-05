#The Kubernetes package provides a few services:
# kube-apiserver,
# kube-scheduler,
# kube-controller-manager,
# kubelet,
# kube-proxy.

# Hostnames should be same accross the Kubernetes cluster. Hav ethe following in /etc/hosts 
# on all hosts of the cluster. (You can use IP of your choice - ofcourse!).

#ex
# 127.0.0.1 localhost localhost.localdomain
# 192.168.124.30 centos-master
# 192.168.124.31 centos-minion

echo "192.168.1.203 kubernetes.vm" >> /etc/hosts
echo "192.168.1.64 kubernetes2.vm" >> /etc/hosts
echo "192.168.1.65 kubernetes3.vm" >> /etc/hosts

touch /etc/yum.repos.d/virt7-docker-common-release.repo

echo "[virt7-docker-common-release]
 name=virt7-docker-common-release
 baseurl=http://cbs.centos.org/repos/virt7-docker-common-release/x86_64/os/
 gpgcheck=0" >> /etc/yum.repos.d/virt7-docker-common-release.repo

yum -y install --enablerepo=virt7-docker-common-release kubernetes etcd

#slave node: 
#yum -y install --enablerepo=virt7-docker-common-release kubernetes

systemctl disable iptables-services firewalld
systemctl stop iptables-services firewalld

echo ' KUBE_LOGTOSTDERR="--logtostderr=true"
 KUBE_LOG_LEVEL="--v=0"
 KUBE_ALLOW_PRIV="--allow-privileged=false"
 KUBE_ETCD_SERVERS="--etcd-servers=http://kubernetes.vm:2379"' >> /etc/kubernetes/config 

echo ' KUBE_API_ADDRESS="--insecure-bind-address=0.0.0.0"
 KUBE_API_PORT="--port=8080"
 KUBELET_PORT="--kubelet-port=10250"
 KUBE_ETCD_SERVERS="--etcd-servers=http://127.0.0.1:2379"
 KUBE_SERVICE_ADDRESSES="--service-cluster-ip-range=10.254.0.0/16"
 ## KUBE_ADMISSION_CONTROL="--admission-control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ServiceAccount,ResourceQuota"
 KUBE_API_ARGS=""
 KUBE_MASTER="--master=http://kubernetes.vm:8080" ' >> /etc/kubernetes/apiserver

for SERVICES in etcd kube-apiserver kube-controller-manager kube-scheduler; do 
systemctl restart $SERVICES
systemctl enable $SERVICES
systemctl status $SERVICES 
done

# slave 
# echo 'KUBELET_ADDRESS="--address=0.0.0.0"
# KUBELET_PORT="--port=10250"
# KUBELET_HOSTNAME="--hostname-override=centos-minion"
# KUBELET_API_SERVER="--api-servers=http://centos-master:8080"
# KUBELET_POD_INFRA_CONTAINER="--pod-infra-container-image=registry.access.redhat.com/rhel7/pod-infrastructure:latest"
# KUBELET_ARGS=""'

#for SERVICES in kube-proxy kubelet docker; do 
#    systemctl restart $SERVICES
#    systemctl enable $SERVICES
#    systemctl status $SERVICES 
#done


