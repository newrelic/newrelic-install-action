#!/bin/sh

result=$(python3 --version)
result="$result\n"$(/root/.local/bin/ansible --version)


echo "$result"

success=$(echo "$result" | grep SUCCESS | wc -l)
echo "success=$success" >> $GITHUB_ENV
exit 0
