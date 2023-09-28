FROM ghcr.io/julien4218/ansible-runner:main

RUN /root/.local/bin/ansible-galaxy collection install ansible.windows ansible.utils
RUN /root/.local/bin/ansible-galaxy install newrelic.newrelic_install

# Copies your code file from your action repository to the filesystem path `/` of the container
# COPY entrypoint.sh /entrypoint.sh
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
