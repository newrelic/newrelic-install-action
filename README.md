# Install New Relic action

A GitHub Action to install New Relic on a given list of hosts using Ansible and SSH. More info regarding installation capabilities at https://github.com/newrelic/ansible-install


## Inputs

| Key              | Required | Default | Description |
| ---------------- | -------- | ------- | ----------- |
| `apiKey`         | **yes**  | -       | Your New Relic [User API key](https://docs.newrelic.com/docs/apis/intro-apis/new-relic-api-keys/#api-table). |
| `accountId` | **yes** | - | Your New Relic AccountID. |
| `region` | no | `US` | The region of your New Relic account. Default: `US` |
| `inventory` | **yes** | - | The list of IPs delimited by commas to use as the source inventory. |
| `ssh_user` | **yes** | - | The user name for either the SSH or WinRM connection. |
| `user_password` | no | - | Used for Windows host with WinRM. `winrm_enable` must be set to `true`. |
| `winrm_enable` | no | - | `true` when using WinRM to connect to a Windows host(s). `password` must be used when enabled. This configuration also disables the WinRM server certificate validation. Default: `false`. |
| `ssh_key_file` | no  | - | The SSH private key file to use for connecting (Linux or Windows/OpenSSH). Note, ensure you're storing this file securely, using [GitHub Secrets](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions) for example. |
| `ssh_known_hosts_check_enable` | no  | `true` | To enable/disable the known host check when connecting with SSH (deault `true`). |
| `install_targets` | **yes**  | - | The list of targets to install separated by commas. Target names are listed on https://github.com/newrelic/ansible-install#targets-required . |
| `install_tags` | no  | - | An optional list of key:value pairs separated by commas representing tags to add to any of the installations. |
| `install_environment` | no  | - | An optional list of key:value pairs separated by commas representing environment variables to pass to any of the installations. |

## Example usage

### GitHub secrets

[Github secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#about-encrypted-secrets) assumed to be set:
* `NEW_RELIC_API_KEY` - Personal API key
* `NEW_RELIC_ACCOUNT_ID` - New Relic AccountID
* `NEW_RELIC_USER_PASSWORD` - Password for the user when using WinRM instead of SSH to connect to a Windows host

>*There are a number of [default GitHub environment variables](https://docs.github.com/en/actions/learn-github-actions/variables#default-environment-variables) that are used in these examples as well.*


```yaml
name: Install New Relic
on:
  - release
      types: [published]

jobs:
  newrelic:
    runs-on: ubuntu-latest
    name: New Relic
    steps:
      - name: Main Install
        uses: julien4218/newrelic-install-action@v[TBD]
        with:
          apiKey: ${{ secrets.NEW_RELIC_API_KEY }}
          accountId: ${{ secrets.NEW_RELIC_ACCOUNT_ID }}
          inventory: "1.1.1.1,1.1.1.2"
          ssh_user: "ec2-user"
          ssh_key_file: "/path/to/file.pem"
          install_targets: "infrastructure,logs,apm-php"
          install_tags: "foo1:bar1,foor2:bar2"
```
