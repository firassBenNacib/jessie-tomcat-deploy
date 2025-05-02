#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT=${1:-}

if [[ -z "$ENVIRONMENT" ]]; then
  echo "Usage: $0 <ENVIRONMENT>"
  exit 1
fi

echo -e "\nDeploying Tomcat with Ansible\n--------------------------------"
ansible-playbook --extra-vars="env=${ENVIRONMENT}" /data/ansible-playbook/tomcat_deploy.yml
echo

echo "Checking Java process"
echo "------------------------"
ps -ef | grep -E '[j]ava' || echo "No Java process found"
echo

echo "Checking Tomcat service status"
echo "---------------------------------"
systemctl status tomcat || echo "Tomcat service not found"
echo

echo "Checking application home page"
echo "---------------------------------"
sleep 5
if curl -fs http://localhost:8080/sample/ >/dev/null; then
  echo "Sample app is reachable ✔"
else
  echo "Failed to reach Tomcat sample app"
fi
echo

echo "Checking Tomcat logs"
echo "------------------------"
cat /opt/tomcat9/logs/catalina.out || echo "Log file not found"
