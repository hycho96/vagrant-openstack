#!/bin/bash 
# #!/bin/bash -eux
echo "##################### deploy-node.sh #########"
# Install Ansible repository.
rm -f /vagrant/logs/deploy-node.log 2>/dev/null
mkdir -p /vagrant/logs
touch /vagrant/logs/deploy-node.log
yum install -y https://rdoproject.org/repos/openstack-train/rdo-release-train.rpm | tee --append  /vagrant/logs/deploy-node.log 
yum install -y git ntp ntpdate openssh-server python-devel sudo '@Development Tools' | tee --append /vagrant/logs/deploy-node.log 

systemctl stop firewalld | tee --append /vagrant/logs/deploy-node.log  
systemctl mask firewalld | tee --append /vagrant/logs/deploy-node.log


mkdir -p /opt/openstack-ansible | tee --append /vagrant/logs/deploy-node.log
cd /opt/openstack-ansible | tee --append  /vagrant/logs/deploy-node.log
git clone -b 20.1.1 https://github.com/openstack/openstack-ansible.git /opt/openstack-ansible
/opt/openstack-ansible/scripts/bootstrap-ansible.sh | tee --append /vagrant/logs/deploy-node.log
rm -rf /etc/openstack_deploy/
cp -irf /opt/openstack-ansible/etc/openstack_deploy/ /etc/

#yum install epel-release -y
#yum install python-pip libpython-dev -y
#pip install --upgrade pip
