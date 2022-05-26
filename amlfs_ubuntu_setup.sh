#!/bin/bash
#for building amlfs on ubuntu, so far tested only on ubuntu 18.04

MGS_IP=$1

sudo su -
apt-get update
apt install -y linux-image-$(uname -r) libtool m4 autotools-dev automake libelf-dev build-essential debhelper devscripts fakeroot kernel-wedge libudev-dev libpci-dev texinfo xmlto libelf-dev python-dev liblzma-dev libaudit-dev dh-systemd libyaml-dev module-assistant libreadline-dev dpatch libsnmp-dev quilt python3.7 python3.7-dev python3.7-distutils pkg-config libselinux1-dev mpi-default-dev libiberty-dev libpython3.7-dev libpython3-dev swig flex bison

git clone git://git.whamcloud.com/fs/lustre-release.git
cd lustre-release
git checkout 2.14.0
git reset --hard && git clean -dfx && sh autogen.sh

./configure --disable-server --with-o2ib=no
make debs -j 28
sudo apt install /root/lustre-release/debs/lustre-client-modules-5.4.0-1063-azure_2.14.0-1_amd64.deb
apt install /root/lustre-release/debs/lustre-client-modules-5.4.0-1063-azure_2.14.0-1_amd64.deb

sudo apt install /root/lustre-release/debs/lustre-client-utils_2.14.0-1_amd64.deb
apt install /root/lustre-release/debs/lustre-client-utils_2.14.0-1_amd64.deb

sudo mkdir /amlfs
sudo mount -t lustre -o noatime.flock ${MGS_IP}@tcp:/lustrefs /amlfs
