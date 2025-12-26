#!/bin/bash
set -e

# ansible-playbook -i "002-tools_install/ansible/inventory/aws_ec2.yml"  -e toolname=vault  002-tools_install/ansible/playbooks/main.yml  --limit tag_Tool_vault

# ansible-playbook -i "002-tools_install/ansible/inventory/aws_ec2.yml"  -e toolname=vault /home/ec2-user/AWS-Terraform-GithubActions-Infra-1/002-tools_install/ansible/playbooks/main.yml

# echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
# source ~/.bashrc

# sudo yum install python3.11-devel  python3.11-pip -y
# sudo pip3.11 install ansible botocore boto3

# # 1. Download the RPM for RHEL/Amazon Linux (64-bit)
# curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm" -o "session-manager-plugin.rpm"

# # 2. Install it using sudo
# sudo yum install -y session-manager-plugin.rpm


TOOL=$1
ENV=$2

# Always resolve ansible base directory correctly
ANSIBLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

INVENTORY="$ANSIBLE_DIR/inventory/aws_ec2.yml"
PLAYBOOK="$ANSIBLE_DIR/playbooks/main.yml"

echo "ANSIBLE_DIR  = $ANSIBLE_DIR"
echo "INVENTORY   = $INVENTORY"
echo "PLAYBOOK    = $PLAYBOOK"

TARGET_LIMIT="tag_Tool_${TOOL}:&tag_Env_${ENV}"

# ansible-playbook \
#   -i "inv.ini" \
#  -e ansible_username=ec2-user \
#  -e ansible_password=DevOps321 \
#   "$PLAYBOOK" \
#   -e "toolname=$TOOL"

#######Running this from workstation

# ansible-playbook \
#   -i /home/ec2-user/AWS-Terraform-GithubActions-Infra-1/002-tools_install/ansible/inventory/aws_ec2.yml \
#    -e "ansible_aws_ssm_bucket_name=my-ansible-transfer-bucket-1312" \
#    -e "ansible_aws_ssm_region=us-east-1" \
#   -e "toolname=$TOOL" \
#   /home/ec2-user/AWS-Terraform-GithubActions-Infra-1/002-tools_install/ansible/playbooks/main.yml \
#   -vvv

#######Run this using CI/CD
  ansible-playbook \
  -i  $INVENTORY \
   -e "ansible_aws_ssm_bucket_name=my-ansible-transfer-bucket-1312" \
   -e "ansible_aws_ssm_region=us-east-1" \
  -e "toolname=$TOOL" -e "env=$ENV" --limit $TARGET_LIMIT \
     $PLAYBOOK
 