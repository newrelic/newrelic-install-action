#!/bin/sh

python3 --version
/root/.local/bin/ansible --version

rm -f hosts
export IFS=","
for item in $NEW_RELIC_INVENTORY; do
    host_param=$(echo "$item ansible_user=\"$NEW_RELIC_SSH_USER\"")
    if [ "$NEW_RELIC_WINRM_ENABLED" = "true" ]; then
        host_param="$host_param ansible_connection=\"winrm\" ansible_port=\"5986\" ansible_winrm_server_cert_validation=\"ignore\" ansible_password=\"$NEW_RELIC_USER_PASSWORD\""
    else
        host_param="$host_param ansible_connection=\"ssh\""
        if [ -n "$NEW_RELIC_SSH_KEY_FILE" ]; then
            host_param="$host_param ansible_ssh_private_key_file=\"$NEW_RELIC_SSH_KEY_FILE\""
        fi
    fi
    echo "$host_param" | tee -a hosts > /dev/null
done

rm -f playbook.yaml
tee -a playbook.yaml > /dev/null <<"EOT"
- name: Install New Relic
  hosts: all
  roles:
    - role: newrelic.newrelic_install
      vars:
EOT

echo "        targets:" | tee -a playbook.yaml > /dev/null
export IFS=","
for item in $NEW_RELIC_INSTALL_TARGETS; do
    echo "          - $item" | tee -a playbook.yaml > /dev/null
done

echo "        tags:" | tee -a playbook.yaml > /dev/null
echo "          - nr_deployed_by: newrelic-install-action" | tee -a playbook.yaml > /dev/null
export IFS=","
for item in $NEW_RELIC_INSTALL_TAGS; do
    format_item=$(echo $item | sed "s/ //g" | sed "s/:/: /g")
    echo "          - $format_item" | tee -a playbook.yaml > /dev/null
done

echo "  environment:" | tee -a playbook.yaml > /dev/null
export IFS=","
for item in $NEW_RELIC_INSTALL_ENVIRONMENT; do
    format_item=$(echo $item | sed "s/ //g" | sed "s/:/: /g")
    echo "    - $format_item" | tee -a playbook.yaml > /dev/null
done
echo "    NEW_RELIC_API_KEY: $NEW_RELIC_API_KEY" | tee -a playbook.yaml > /dev/null
echo "    NEW_RELIC_ACCOUNT_ID: $NEW_RELIC_ACCOUNT_ID" | tee -a playbook.yaml > /dev/null
echo "    NEW_RELIC_REGION: $NEW_RELIC_REGION" | tee -a playbook.yaml > /dev/null

# debug
# cat hosts
# cat playbook.yaml

ANSIBLE_HOST_KEY_CHECKING=$NEW_RELIC_SSH_KNOWN_HOSTS_CHECK_ENABLE /root/.local/bin/ansible-playbook -i hosts playbook.yaml
exitStatus=$?

if [ $exitStatus -ne 0 ]; then
  echo "::error:: $result"
fi

# Cleanup
rm -f hosts
rm -f playbook.yaml

exit $exitStatus
