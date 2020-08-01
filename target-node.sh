#!/bin/bash


rm -f /vagrant/logs/target-node.log 2>/dev/null
mkdir -p /vagrant/logs
touch /vagrant/logs/target-node.log

# Install additional software packages
yum install -y bridge-utils iputils lsof lvm2 chrony openssh-server sudo tcpdump python | tee --append /vagrant/logs/target-node.log 

# Add the appropriate kernel modules to the /etc/modules-load.d file to enable VLAN and bond interfaces:
echo 'bonding' >> /etc/modules-load.d/openstack-ansible.conf | tee --append /vagrant/logs/target-node.log
echo '8021q' >> /etc/modules-load.d/openstack-ansible.conf | tee --append /vagrant/logs/target-node.log

# Configure Network Time Protocol (NTP) in /etc/chrony.conf to synchronize with a suitable time source and start the service

systemctl enable chronyd.service | tee --append /vagrant/logs/target-node.log
systemctl restart chronyd.service | tee --append /vagrant/logs/target-node.log

