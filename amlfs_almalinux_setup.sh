#!/bin/bash

MGS_IP=$1

sudo yum groupinstall "Development Tools" -y
sudo dnf config-manager --set-enabled powertools

sudo yum install rpm-build wget which kernel kernel-devel libyaml-devel zlib-devel binutils-devel libselinux-devel -y
wget https://downloads.whamcloud.com/public/lustre/lustre-2.14.0/el8.3/client/SRPMS/lustre-2.14.0-1.src.rpm
sudo rpm -i lustre-2.14.0-1.src.rpm
sudo yum install kernel-abi-whitelists -y
sudo rpmbuild -ba /root/rpmbuild/SPECS/lustre.spec --without=servers --without=lustre_tests --without=mpi -D "kver $(ls /lib/modules)" --define "configure_args --with-o2ib=no"
sudo rpm -ivh /root/rpmbuild/RPMS/x86_64/kmod-lustre-client-2.14.0-1.el8.x86_64.rpm --nodeps
sudo rpm -ivh /root/rpmbuild/RPMS/x86_64/kmod-lustre-client-debuginfo-2.14.0-1.el8.x86_64.rpm --nodeps
sudo rpm -ivh /root/rpmbuild/RPMS/x86_64/lustre-client-2.14.0-1.el8.x86_64.rpm --nodeps
sudo rpm -ivh /root/rpmbuild/RPMS/x86_64/lustre-client-debuginfo-2.14.0-1.el8.x86_64.rpm --nodeps
sudo rpm -ivh /root/rpmbuild/RPMS/x86_64/lustre-client-debugsource-2.14.0-1.el8.x86_64.rpm --nodeps
sudo rpm -ivh /root/rpmbuild/RPMS/x86_64/lustre-client-devel-2.14.0-1.el8.x86_64.rpm --nodeps


sudo mkdir /amlfs
sudo mount -t lustre -o noatime.flock ${MGS_IP}@tcp:/lustrefs /amlfs
