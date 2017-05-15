#!/bin/bash
sudo -i 
echo "disable all repositories and enable only the required ones..."
#subscription-manager register --auto-attach --force
subscription-manager repos --disable="*" > /dev/null
subscription-manager repos \
    --enable="rhel-7-server-rpms" \
    --enable="rhel-7-server-extras-rpms" \
    --enable="rhel-7-server-ose-3.5-rpms" \
    --enable="rhel-7-fast-datapath-rpms"
subscription-manager repos --enable rhel-7-server-optional-rpms
subscription-manager refresh 
echo " yum repolist"
yum repolist
echo "/etc/yum.conf "
cat /etc/yum.conf 
echo "install epel"
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
echo "install atomic-openshift-utils,python2-boto,...."
yum -y install ansible atomic-openshift-utils
yum -y install --enablerepo=epel \
                 python2-boto \
                 python2-boto3 \
                 pyOpenSSL \
                 git \
                 python-netaddr \
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

