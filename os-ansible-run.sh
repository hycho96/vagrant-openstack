#

╭─hycho@K0712P2 ~/OpenStack/OS_test2-OS-Ansible/vagrant-openstack ‹master*›
╰─$ vim network-hycho.sh
#!/bin/bash

echo "##################### hosts.sh #########"
cp -i /etc/sysconfig/network-scripts/ /etc/sysconfig/network-scripts/backup/
yum install bridge-utils vim traceroute -y
. /vagrant/shell-hycho.sh

echo "
192.168.100.1:/Users/hycho/OpenStack/OS_test2-OS-Ansible/vagrant-openstack /vagrant2		nfs	defaults,_netdev	0 0
" >>  /etc/fstab
mount /vagrant

╭─hycho@K0712P2 ~/OpenStack/OS_test2-OS-Ansible/vagrant-openstack ‹master*›
╰─$ vim deploy-node.sh

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

#yum install epel-release -y
#yum install python-pip libpython-dev -y
#pip install --upgrade pip

╭─hycho@K0712P2 ~/OpenStack/OS_test2-OS-Ansible/vagrant-openstack ‹master*›
╰─$ vim deploy-node.sh

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

#yum install epel-release -y
#yum install python-pip libpython-dev -y
#pip install --upgrade pip
╭─hycho@K0712P2 ~/OpenStack/OS_test2-OS-Ansible/vagrant-openstack ‹master*›
╰─$

# All Node : Make root password 
[root@deploy:~/.ssh]# passwd
Changing password for user root.
New password:
Retype new password:
passwd: all authentication tokens updated successfully.
[root@deploy:~/.ssh]# passwd
Changing password for user root.
New password:
BAD PASSWORD: The password is shorter than 8 characters
Retype new password:
passwd: all authentication tokens updated successfully.

# All Node : cp ssh-key
[root@deploy:~/.ssh]# ssh-copy-id -i ~/.ssh/id_rsa.pub root@compute-01

# Deploy Node :설정 파일 확인
root@deploy:/vagrant/openstack-ansible-scripts]# cp openstack_user_config-hycho1.yml /etc/openstack_deploy/
[root@deploy:/vagrant/openstack-ansible-scripts]# cp user_variables-hycho1.yml /etc/openstack_deploy

# Storage Node : storage 
conterller-01 /dev/sdb 추가

sh storage-node.sh

#!/bin/bash -eux

echo "###################### run storage-node.sh ##############"
# Install Ansible repository.
rm -f /vagrant/logs/storage-node.log 2>/dev/null
mkdir -p /vagrant/logs
touch /vagrant/logs/storage-node.log

mkdir /vagrant/a | tee /vagrant/logs/storage-node.log
pvcreate --metadatasize 2048 /dev/sdb | tee /vagrant/logs/storage-node.log
vgcreate cinder-volumes /dev/sdb | tee /vagrant/logs/storage-node.log


[root@controller-01 vagrant]# sh storage-node.sh
###################### run storage-node.sh ##############
mkdir: cannot create directory ‘/vagrant/a’: File exists
  Physical volume "/dev/sdb" successfully created.
  Volume group "cinder-volumes" successfully created
[root@controller-01 vagrant]# fdisk -l

Disk /dev/sda: 68.7 GB, 68719476736 bytes, 134217728 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x0009ce01

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048     2099199     1048576   83  Linux
/dev/sda2         2099200   134217727    66059264   8e  Linux LVM

Disk /dev/sdb: 12.9 GB, 12884901888 bytes, 25165824 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

# Deploy Node : Copy the contents of the /opt/openstack-ansible/etc/openstack_deploy directory to the /etc/openstack_deploy directory.
cp -ir /opt/openstack-ansible/etc/openstack_deploy/ /etc/

# Deploy Node : Run the playbooks to install OpenStack¶
/opt/openstack-ansible/playbooks 
openstack-ansible setup-hosts.yml
