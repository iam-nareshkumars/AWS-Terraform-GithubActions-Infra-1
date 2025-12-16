#!/bin/bash
set -e

TOOL=$1

ansible-playbook 002-tools_install/playbooks/main.yml
