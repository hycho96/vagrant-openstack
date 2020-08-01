#!/bin/bash -eux

# Install Ansible repository.
rm -f /vagrant/logs/storage-node.log 2>/dev/null
mkdir -p /vagrant/logs
touch /vagrant/logs/storage-node.log

mkdir /vagrant/a | tee /vagrant/logs/storage-node.log
pvcreate --metadatasize 2048 /dev/sdb | tee /vagrant/logs/storage-node.log
vgcreate cinder-volumes /dev/sdb | tee /vagrant/logs/storage-node.log

