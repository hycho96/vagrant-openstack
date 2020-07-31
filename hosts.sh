#!/bin/bash

echo "##################### hosts.sh #########"
cp -i /etc/sysconfig/network-scripts/ /etc/sysconfig/network-scripts/backup/
yum install bridge-utils vim traceroute -y
. /vagrant/shell-hycho.sh

echo "
192.168.100.1:/Users/hycho/OpenStack/OS_test2-OS-Ansible/vagrant-openstack /vagrant2		nfs	defaults,_netdev	0 0
" >>  /etc/fstab
mount /vagrant
