cd /home/vagrant/AWS/openshift-ansible-contrib/reference-architecture/aws-ansible
./ose-on-aws.py  -v \
	--public-hosted-zone=$DOMAIN \
	--keypair=OSE-key \
	--rhsm-user=$SUB_USERNAME \
        --rhsm-password=$SUB_PASSWORD \
	--rhsm-pool=$SUB_POOLID \
	--master-instance-type=m4.large \
	--node-instance-type=m4.xlarge \
	--app-instance-type=m4.xlarge \
	--region=$REGION \
	--ami=$AMI \
	--create-key=yes \
	--key-path=/root/.ssh/id_rsa.pub \
	--github-client-secret=$GITHUB-CLIENT-SECRET \
	--github-organization=$GITHUB-ORGANIZATION \
        --github-client-id=$GITHUB-CLIENT-ID
