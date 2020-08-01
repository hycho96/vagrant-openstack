#!/bin/bash


cp -i /etc/sysconfig/network-scripts/ /etc/sysconfig/network-scripts/backup/
yum install bridge-utils vim -y

echo "
192.168.100.5 deploy-01
192.168.100.9 logging-01
192.168.100.10 controller-01 	
192.168.100.11 controller-02
192.168.100.12 controller-03
192.168.100.13 compute-01
192.168.100.14 compute-02
192.168.100.50 storage-01
192.168.100.99 openstack-client" >> /etc/hosts

echo "
DEVICE=eth4
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED="no"
#DELAY=10
BRIDGE=br-ex" > /etc/sysconfig/network-scripts/gifcfg-eth4

echo "
DEVICE=eth1
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED="no"
#DELAY=10
BRIDGE=br-mgmt" > /etc/sysconfig/network-scripts/gifcfg-eth1

echo "
DEVICE=eth2
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED="no"
#DELAY=10
BRIDGE=br-vxlan" > /etc/sysconfig/network-scripts/gifcfg-eth2

echo "
DEVICE=eth3
TYPE=Ethernet
BOOTPROTO=none
ONBOOT=yes
NM_CONTROLLED="no"
#DELAY=10
BRIDGE=br-storage" > /etc/sysconfig/network-scripts/gifcfg-eth3

echo "
DEVICE=br-ex
NAME=br-ex
NM_CONTROLLED="no"
TYPE=Bridge
IPADDR=10.10.0.__IP__
PREFIX=22
GATEWAY=10.10.0.11
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
