#!/bin/bash
cd /home/vagrant/AWS/openshift-ansible-contrib/reference-architecture/aws-ansible
echo "ansible-playbook -i inventory/aws/hosts -e 'region=$REGION stack_name=openshift-infra ci=true' playbooks/teardown.yaml"
read -p "Are you sure you wish to continue? (yes/no)"
if [ "$REPLY" != "yes" ]; then
   exit
fi
echo "Destroying Installation on AWS..."
eval $(echo "ansible-playbook -i inventory/aws/hosts -e 'region=$REGION stack_name=openshift-infra ci=true' playbooks/teardown.yaml")
