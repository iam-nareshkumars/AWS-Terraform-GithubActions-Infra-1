#!/bin/bash
set -e

TOOL=$1

ansible-playbook -i "002-tools_install\ansible\inventory\aws_ec2.yml"  -e toolname=$1 002-tools_install/ansible/main.yml
