#!/bin/sh

result=$(python3 --version)
result="$result\n"$(/root/.local/bin/ansible --version)


echo "$result"
echo "result=$result" >> $GITHUB_ENV
exit 0
