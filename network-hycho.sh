#!/bin/bash -eux

echo " ########################### network-hycho.sh #########"
echo "
172.29.236.5 deploy-01
172.29.236.6 controller-01 	
172.29.236.7 controller-02
172.29.236.8 controller-03
172.29.236.13 compute-01
172.29.236.14 compute-02
172.29.236.50 storage-01
172.29.236.51 storage-02
172.29.236.52 storage-03
172.29.236.53 storage-04
172.29.236.54 storage-05
172.29.236.55 storage-06
172.29.236.99 openstack-client" >> /etc/hosts

echo "
DEVICE=eth5
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED="no"
DELAY=10
BRIDGE=br-ex" > /etc/sysconfig/network-scripts/ifcfg-eth5

echo "
DEVICE=eth2
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED="no"
DELAY=10
BRIDGE=br-mgmt" > /etc/sysconfig/network-scripts/ifcfg-eth2

echo "
DEVICE=eth3
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED="no"
DELAY=10
BRIDGE=br-vxlan" > /etc/sysconfig/network-scripts/ifcfg-eth3

echo "
DEVICE=eth4
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED="no"
DELAY=10
BRIDGE=br-storage" > /etc/sysconfig/network-scripts/ifcfg-eth4

echo "
DEVICE=br-ex
NAME=br-ex
NM_CONTROLLED="no"
TYPE=Bridge
IPADDR=10.10.0.__IP__
PREFIX=22
GATEWAY=10.0.2.2
DNS1=8.8.8.8
BOOTPROTO=static" >  /etc/sysconfig/network-scripts/ifcfg-br-ex

IP=$(ifconfig eth1 | awk '/inet\ / {print $2}' | cut -d '.' -f4)
sed -i "s/__IP__/${IP}/g" /etc/sysconfig/network-scripts/ifcfg-br-ex

echo "
DEVICE=br-mgmt
NAME=br-mgmt
NM_CONTROLLED="no"
TYPE=Bridge
IPADDR=172.29.236.__IP__
PREFIX=22
BOOTPROTO=static" > /etc/sysconfig/network-scripts/ifcfg-br-mgmt

IP=$(ifconfig eth1 | awk '/inet\ / {print $2}' | cut -d '.' -f4)
sed -i "s/__IP__/${IP}/g" /etc/sysconfig/network-scripts/ifcfg-br-mgmt

echo "
DEVICE=br-vxlan
NAME=br-vxlan
NM_CONTROLLED="no"
TYPE=Bridge
IPADDR=172.29.240.__IP__
PREFIX=22
BOOTPROTO=static" > /etc/sysconfig/network-scripts/ifcfg-br-vxlan

IP=$(ifconfig eth1 | awk '/inet\ / {print $2}' | cut -d '.' -f4)
sed -i "s/__IP__/${IP}/g" /etc/sysconfig/network-scripts/ifcfg-br-vxlan

echo "
DEVICE=br-storage
NAME=br-storage
NM_CONTROLLED="no"
TYPE=Bridge
IPADDR=172.29.244.__IP__
PREFIX=22
BOOTPROTO=static" > /etc/sysconfig/network-scripts/ifcfg-br-storage

IP=$(ifconfig eth1 | awk '/inet\ / {print $2}' | cut -d '.' -f4)
sed -i "s/__IP__/${IP}/g" /etc/sysconfig/network-scripts/ifcfg-br-storage

systemctl restart network
ping -c 5 google.com 
#yum upgrade -y
