#!/bin/bash -eux

# Install Ansible repository.
rm -f /vagrant/logs/deploy-node.log 2>/dev/null
mkdir -p /vagrant/logs
touch /vagrant/logs/deploy-node.log
yum install -y https://rdoproject.org/repos/openstack-train/rdo-release-train.rpm | tee  --append --output-error=exit /vagrant/logs/deploy-node.log 
yum install -y git ntp ntpdate openssh-server python-devel sudo '@Development Tools' | tee --append --output-error=exit /vagrant/logs/deploy-node.log 

systemctl stop firewalld | tee  --append --output-error=exit /vagrant/logs/deploy-node.log    
systemctl mask firewalld | tee --append --output-error=exit /vagrant/logs/deploy-node.log


#mkdir /opt/openstack-ansible | tee --append --output-error=exit /vagrant/logs/deploy-node.log
mkdir /opt/openstack-ansible
cd /opt/openstack-ansible 
git clone -b 20.1.1 https://gcripts/bootstrap-ansible.shthub.com/openstack/openstack-ansible.git /opt/openstack-ansible 
sh /opt/openstack-ansible/sripts/bootstrap-ansible.sh 
