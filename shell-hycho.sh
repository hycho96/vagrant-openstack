#!/bin/bash


echo "
# Source hycho definitions
if [ -f /vagrant/Shell/bashrc ]; then
        . /vagrant/Shell/bashrc
        . /vagrant/Shell/.bashrc
fi" >> ~/.bashrc

. ~/.bashrc
. /vagrant/Shell/.bashrc
