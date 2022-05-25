#!/bin/bash

MGS_IP=$1


sudo yum install pssh -y

wget https://downloads.whamcloud.com/public/lustre/lustre-2.14.0/el8.3/client/SRPMS/lustre-2.14.0-1.src.rpm

echo $(hostname) > hosts.txt

if command -v pbsnodes --version &> /dev/null
then
	pbsnodes -avS | grep free | awk -F ' ' '{print $1}' >> hosts.txt
fi

pssh -p 194 -t 0 -i -h ehosts.txt "cd $CDIR && ./amlfs_setup.sh $MGS_IP" >> amlfs_pssh.log 2>&1
