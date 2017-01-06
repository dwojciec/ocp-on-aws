cd /home/vagrant/AWS/openshift-ansible-contrib/reference-architecture/aws-ansible
echo "./ose-on-aws.py  -v \
        --public-hosted-zone=$DOMAIN \
        --keypair=OSE-key \
        --rhsm-user=$SUB_USERNAME \
        --rhsm-password=$SUB_PASSWORD \
        --rhsm-pool=$SUB_POOLID \
        --master-instance-type=m4.large \
        --node-instance-type=t2.medium \
        --app-instance-type=t2.medium \
        --region=$REGION \
        --ami=$AMI \
        --create-key=yes \
        --key-path=/root/.ssh/id_rsa.pub \
        --github-client-secret=$GITHUB_CLIENT_SECRET \
        --github-organization=$GITHUB_ORGANIZATION \
        --github-client-id=$GITHUB_CLIENT_ID"

read -p "Are you sure you wish to continue? (yes/no)"
if [ "$REPLY" != "yes" ]; then
   exit
fi
echo "deploying OCP on AWS..."
./ose-on-aws.py  -v \
	--public-hosted-zone=$DOMAIN \
	--keypair=OSE-key \
	--rhsm-user=$SUB_USERNAME \
        --rhsm-password=$SUB_PASSWORD \
	--rhsm-pool=$SUB_POOLID \
	--master-instance-type=m4.large \
	--node-instance-type=t2.medium \
	--app-instance-type=t2.medium \
	--region=$REGION \
	--ami=$AMI \
	--create-key=yes \
	--key-path=/root/.ssh/id_rsa.pub \
	--github-client-secret=$GITHUB_CLIENT_SECRET \
	--github-organization=$GITHUB_ORGANIZATION \
        --github-client-id=$GITHUB_CLIENT_ID
