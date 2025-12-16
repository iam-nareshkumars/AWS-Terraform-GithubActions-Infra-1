#!/bin/bash
set -e

TOOL=$1

ansible-playbook 002-tools_install/ansible/playbooks/main.yml
