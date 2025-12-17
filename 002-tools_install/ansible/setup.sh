#!/bin/bash
set -e

# ansible-playbook -i "002-tools_install/ansible/inventory/aws_ec2.yml"  -e toolname=vault  002-tools_install/ansible/playbooks/main.yml  --limit tag_Tool_vault

ansible-playbook -i "002-tools_install/ansible/inventory/aws_ec2.yml"  -e toolname=vault /home/ec2-user/AWS-Terraform-GithubActions-Infra-1/002-tools_install/ansible/playbooks/main.yml
