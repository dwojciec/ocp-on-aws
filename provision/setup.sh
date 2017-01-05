#!/bin/bash
sudo -i 
echo "disable all repositories and enable only the required ones..."
subscription-manager repos --disable="*" > /dev/null
subscription-manager repos --enable rhel-7-server-optional-rpms
subscription-manager repos --enable rhel-7-server-extras-rpms
subscription-manager repos --enable rhel-7-server-ose-3.3-rpms
subscription-manager repos --enable rhel-7-server-rpms
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
echo "install atomic-openshift-utils,python2-boto,...."
yum -y install atomic-openshift-utils \
                 python2-boto \
                 git \
                 ansible-2.2.0.0-3.el7.noarch \
                 python-netaddr \
                 python2-boto3 \
                 python-click \
                 python-httplib2
echo " install ntp server to avoid to have desync issue with AWS"
yum -y install ntp 
systemctl enable ntpd
systemctl start ntpd
date
echo " create AWS directory..."
mkdir -p /home/vagrant/AWS
cd /home/vagrant/AWS
echo " clone git repo..."
git clone https://github.com/openshift/openshift-ansible-contrib.git 
cd /home/vagrant/AWS
echo "ssh-keygen.. to generate id_rsa files"
cat /dev/zero | ssh-keygen -q -N ""
echo " configuring config file"
export NEW_DOMAIN=$1
echo "domain Route53 :" $NEW_DOMAIN
sed "s/<DOMAIN>/$NEW_DOMAIN/" <  /vagrant/provision/config.template > /root/.ssh/config

