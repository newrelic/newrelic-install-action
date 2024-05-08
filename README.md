<a href="https://opensource.newrelic.com/oss-category/#community-project"><picture><source media="(prefers-color-scheme: dark)" srcset="https://github.com/newrelic/opensource-website/raw/main/src/images/categories/dark/Community_Project.png"><source media="(prefers-color-scheme: light)" srcset="https://github.com/newrelic/opensource-website/raw/main/src/images/categories/Community_Project.png"><img alt="New Relic Open Source community project banner." src="https://github.com/newrelic/opensource-website/raw/main/src/images/categories/Community_Project.png"></picture></a>

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
        uses: newrelic/newrelic-install-action@v[TBD]
        with:
          apiKey: ${{ secrets.NEW_RELIC_API_KEY }}
          accountId: ${{ secrets.NEW_RELIC_ACCOUNT_ID }}
          inventory: "1.1.1.1,1.1.1.2"
          ssh_user: "ec2-user"
          ssh_key_file: "/path/to/file.pem"
          install_targets: "infrastructure,logs,apm-php"
          install_tags: "foo1:bar1,foor2:bar2"
```

## Support

New Relic hosts and moderates an online forum where customers can interact with
New Relic employees as well as other customers to get help and share best
practices. Like all official New Relic open source projects, there's a related
Community topic in the New Relic Explorers Hub. You can find this project's
topic/threads here:

- [New Relic Documentation](https://docs.newrelic.com): Comprehensive guidance for using our platform
- [New Relic Community](https://forum.newrelic.com): The best place to engage in troubleshooting questions
- [New Relic Developer](https://developer.newrelic.com/): Resources for building a custom observability applications
- [New Relic University](https://learn.newrelic.com/): A range of online training for New Relic users of every level
- [New Relic Technical Support](https://support.newrelic.com/) 24/7/365 ticketed support. Read more about our [Technical Support Offerings](https://docs.newrelic.com/docs/licenses/license-information/general-usage-licenses/support-plan).

## Contribute

We encourage your contributions to improve the `newrelic-install-action` Github action! Keep in mind that when you submit your pull request, you'll need to sign the CLA via the click-through using CLA-Assistant. You only have to sign the CLA one time per project.

If you have any questions, or to execute our corporate CLA (which is required if your contribution is on behalf of a company), drop us an email at opensource@newrelic.com.

**A note about vulnerabilities**

As noted in our [security policy](https://github.com/newrelic/ansible-install/security/policy), New Relic is committed to the privacy and security of our customers and their data. We believe that providing coordinated disclosure by security researchers and engaging with the security community are important means to achieve our security goals.

If you believe you have found a security vulnerability in this project or any of New Relic's products or websites, we welcome and greatly appreciate you reporting it to New Relic through [HackerOne](https://hackerone.com/newrelic).

If you would like to contribute to this project, review [these guidelines](https://github.com/newrelic/newrelic-install-action/blob/main/CONTRIBUTING.md).

To all contributors, we thank you! Without your contribution, this project would not be what it is today.

## License

This project is licensed under the [Apache 2.0](http://apache.org/licenses/LICENSE-2.0.txt) License.
