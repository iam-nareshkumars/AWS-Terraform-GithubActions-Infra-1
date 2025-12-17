#!/bin/bash
set -e

# ansible-playbook -i "002-tools_install/ansible/inventory/aws_ec2.yml"  -e toolname=vault  002-tools_install/ansible/playbooks/main.yml  --limit tag_Tool_vault

# ansible-playbook -i "002-tools_install/ansible/inventory/aws_ec2.yml"  -e toolname=vault /home/ec2-user/AWS-Terraform-GithubActions-Infra-1/002-tools_install/ansible/playbooks/main.yml






TOOL=$1

# Always resolve ansible base directory correctly
ANSIBLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

INVENTORY="$ANSIBLE_DIR/inventory/aws_ec2.yml"
PLAYBOOK="$ANSIBLE_DIR/playbooks/main.yml"

echo "ANSIBLE_DIR  = $ANSIBLE_DIR"
echo "INVENTORY   = $INVENTORY"
echo "PLAYBOOK    = $PLAYBOOK"

# ansible-playbook \
#   -i "inv.ini" \
#  -e ansible_username=ec2-user \
#  -e ansible_password=DevOps321 \
#   "$PLAYBOOK" \
#   -e "toolname=$TOOL"

ansible-playbook \
  -i 002-tools_install/ansible/inventory/aws_ec2.yml \
 -e ansible_username=ec2-user \
 -e ansible_password=DevOps321 \
  002-tools_install/ansible/playbooks/main.yml \
  -e "toolname=$TOOL" \
  -l tag_Tool_vault