#!/bin/bash
set -e

TOOL=$1

ansible-playbook -e toolname=$1 002-tools_install/ansible/playbooks/main.yml
