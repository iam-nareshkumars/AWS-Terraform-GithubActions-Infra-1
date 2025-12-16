#!/bin/bash
set -e

TOOL=$1

cd ansible

ansible-playbook playbooks/main.yml
