FROM ghcr.io/julien4218/ansible-runner:main

RUN /root/.local/bin/ansible-galaxy install newrelic.newrelic_install

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
