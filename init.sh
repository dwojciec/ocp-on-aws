#!/bin/sh 
DEMO="VM Console"
AUTHORS="Didier Wojciechowski"
PROJECT="git@github.com:dwojciec/ocp-on-aws.git"
PRODUCT="Openshift Container Platform on AWS"
SRC_DIR=~/.vagrant.d/boxes
OSX_BOX=gwhorley/rhel72-x86_64
VB_BOX=gwhorley-VAGRANTSLASH-rhel72-x86_64

# wipe screen.
clear 
echo
echo "#######################################################################"
echo "##                                                                   ##"   
echo "##  Setting up the ${DEMO}                                        ##"
echo "##                                                                   ##"   
echo "##                                                                   ##"   
echo "##                                                                   ##"   
echo "##                                                                   ##"   
echo "##  brought to you by ${AUTHORS}                           ##"
echo "##                                                                   ##"   
echo "##  ${PROJECT}                           ##"
echo "##                                                                   ##"   
echo "#######################################################################"
echo
# Ensure Vagrant avaiable.
#
command -v vagrant -v >/dev/null 2>&1 || { echo >&2 "Vagrant is required but not installed yet... download here: https://www.vagrantup.com/downloads.html"; exit 1; }
echo "Vagrant is installed..."
echo 

# Ensure VirtualBox available.
#
if [ `uname` == 'Darwin' ]; then
	command -v VirtualBox -h >/dev/null 2>&1 || { echo >&2 "VirtualBox is required but not installed yet... downlaod here: https://www.virtualbox.org/wiki/Downloads"; exit 1; }
	echo "VirtualBox is installed..."
	echo
fi
# Ensure correct Vagrant box downloaded.
#
if [ `uname` == 'Darwin' ]; then
	# OSX Vagrant box.
	if [ -r $SRC_DIR/$VB_BOX ] || [ -L $SRC_DIR/$VB_BOX ]; then
		echo OSX Vagrant box present...
	  echo
  else
	  echo The box $OSX_BOX will be downloaded during the first run
	  echo The size is 530MB
	  echo
  fi
fi

echo "Installing provided Vagrant plugins..."
echo
vagrant plugin install vagrant-registration
vagrant plugin install vagrant-timezone

echo
echo "Checking that plugins installed, looking for:"
echo 
echo "  -> vagrant-registration"
echo "  -> vagrant-timezone"
echo
vagrant plugin list


echo
echo "Checking that $OSX_BOX is listed..."
echo
vagrant box list

