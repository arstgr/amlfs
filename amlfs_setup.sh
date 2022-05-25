#!/bin/bash

MGS_IP=$1

COSRLS=$(cat /etc/centos-release | awk '{print $4}' | cut -d '.' -f1)

if [ "$COSRLS" = "8" ]
then
	sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
	sudo sed -i 's|baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
	sudo yum groupinstall "Development Tools" -y
	sudo dnf config-manager --set-enabled PowerTools
fi

sudo yum install rpm-build wget which kernel kernel-devel libyaml-devel zlib-devel binutils-devel libselinux-devel -y
sudo rpm -i lustre-2.14.0-1.src.rpm
sudo yum install kernel-abi-whitelists -y
sudo rpmbuild -ba rpmbuild/SPECS/lustre.spec --without=servers --without=lustre_tests --without=mpi -D "kver $(ls /lib/modules)"
sudo rpm -ivh /root/rpmbuild/RPMS/x86_64/kmod-lustre-client-2.14.0-1.el8.x86_64.rpm --nodeps
sudo rpm -ivh /root/rpmbuild/RPMS/x86_64/kmod-lustre-client-debuginfo-2.14.0-1.el8.x86_64.rpm --nodeps
sudo rpm -ivh /root/rpmbuild/RPMS/x86_64/lustre-client-2.14.0-1.el8.x86_64.rpm --nodeps
sudo rpm -ivh /root/rpmbuild/RPMS/x86_64/lustre-client-debuginfo-2.14.0-1.el8.x86_64.rpm --nodeps
sudo rpm -ivh /root/rpmbuild/RPMS/x86_64/lustre-client-debugsource-2.14.0-1.el8.x86_64.rpm --nodeps
sudo rpm -ivh /root/rpmbuild/RPMS/x86_64/lustre-client-devel-2.14.0-1.el8.x86_64.rpm --nodeps


sudo mkdir /amlfs
sudo mount -t lustre -o noatime.flock ${MGS_IP}@tcp:/lustrefs /amlfs
