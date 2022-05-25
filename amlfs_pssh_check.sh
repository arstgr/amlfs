#!/bin/bash

#target directory: a directory to check its existense on the lustre file system
export TDIR=/amlfs/projects/ansys_wr

if command -v pbsnodes --version &> /dev/null
then
	nodes=($(pbsnodes -avS | grep vmss | awk -F ' ' '{print $1}'))
fi

for i in ${nodes[@]}; 
do 
	echo "connecting $i"
	ssh $i '[ -d "$TDIR" ] && echo "SUCCESS: amlfs mounted on $(hostname)" || echo "ERROR: amlfs was not mounted on $(hostname)"' >> amlfs_test_results.log 2>&1
done

