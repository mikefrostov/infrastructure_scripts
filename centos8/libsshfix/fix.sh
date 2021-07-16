#cd /tmp/; wget http://vault.centos.org/8.2.2004/BaseOS/Source/SPackages/krb5-1.17-18.el8.src.rpm
#rpm2cpio krb5-1.17-18.el8.src.rpm | cpio -imdV
#tar xf krb5-1.17.tar.gz
#cd krb5-1.17/src
#LDFLAGS='-L/opt/vagrant/embedded/' ./configure
#make

git clone https://git.centos.org/centos-git-common
# centos-git-common needs its tools in PATH
export PATH=$(readlink -f ./centos-git-common):$PATH
git clone https://git.centos.org/rpms/libssh
cd libssh
git checkout imports/c8s/libssh-0.9.4-1.el8
into_srpm.sh -d c8s
cd SRPMS
ls

# common commands (make sure to adjust verison accordingly)
rpm2cpio libssh-0.9.4-1c8s.src.rpm | cpio -imdV
tar xf libssh-0.9.4.tar.xz
mkdir build
cd build
cmake ../libssh-0.9.4 -DOPENSSL_ROOT_DIR=/opt/vagrant/embedded/
make
#sudo cp lib/libssh* /opt/vagrant/embedded/lib64
sudo cp lib/libssh.so.4 /usr/lib64
