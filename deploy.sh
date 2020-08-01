#!/bin/bash

yum install -y https://rdoproject.org/repos/openstack-train/rdo-release-train.rpm
yum install -y git ntp ntpdate openssh-server python-devel sudo '@Development Tools'

systemctl stop firewalld
systemctl mask firewalld


mkdir /opt/openstack-ansible
cd /opt/openstack-ansible
git clone -b 20.1.1 https://github.com/openstack/openstack-ansible.git /opt/openstack-ansible
sh /opt/openstack-ansible/scripts/bootstrap-ansible.sh
