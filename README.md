# amlfs

Install and Connect Clients to Azure Managed Lustre File System

This repo provides scripts to install lustre clients on Azure HPC VMs and connect them to Azure Managed Lustre File System (AMLFS). The scripts currently support CentOS. Support for additional distros will be added in future. 

A short description of AMLFS, installation and prerequisites can be found [here](https://refactored-lamp-d3380aa5.pages.github.io/amlfs-prerequisites/) and [here](https://refactored-lamp-d3380aa5.pages.github.io/amlfs-mount/). 

To install the lustre client, run

```
./amlfs_pssh.sh $MGS_IP 
```

where MGS_IP denotes the MGS IP address, the IP address for the Azure Managed Lustre file system’s Lustre management service (MGS). 

The scripts launch pssh to install the client on the VMs. The list of VMs currently is obtained through the PBS. Support for other schedulers will be added in future. 

To check if the installation was successful, run

```
amlfs_pssh_check.sh
```

