# Rookery-deploy

This provides an easy way to install Rookery on any server.
It automatically sets up an nginx server, letsencrypt certificates, docker containers.

## Requirements

To run this ansible playbook, you need to:

- Have a Debian 9-based server / VPS where Rookery will run.
- Supported CPU architectures are x86-64 and ARM64.
- Configure a DNS `A` Record to point at your server's IP address.
- Make sure you can ssh to it, with a sudo user: `ssh <your-user>@<your-domain>`
- Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (>= `2.11.0` on your **local** machine (do not install it on your destination server).

### Supported Distribution Playbook Matrix

These are the distributions we currently support. Anything not listed here is currently not supported.
If you wish to see another distribution on the list,
please test on the latest commit in `main` and report your findings via an Issue.

| Distribution | Version   |
| ------------ | --------- |
| Debian       | 10        |
| Debian       | 11        |
| Debian       | 12        |
| Ubuntu       | 22.04 LTS |

## Install

1. Clone this repo & checkout latest tag

   ```
   git clone https://github.com/kevinrutherford/rookery-deploy.git
   cd rookery-deploy
   git checkout $(git describe --tags)
   ```

2. Make a directory to hold your config:

   `mkdir -p inventory/host_vars/<your-domain>`

3. Copy the sample configuration file:

   `cp examples/config.hjson inventory/host_vars/<your-domain>/config.hjson`

   Edit that file and change the config to your liking. Note: **Do not edit anything inside the {{ }} braces.**

   [Here are all the config options.](https://join-lemmy.org/docs/en/administration/configuration.html#full-config-with-default-values)

4. Copy the sample inventory hosts file:

   `cp examples/hosts inventory/hosts`

   Edit the inventory hosts file (inventory/hosts) to your liking.

6. Copy the sample `vars.yml` file

   `cp examples/vars.yml inventory/host_vars/<your-domain>/vars.yml`

   Edit the `inventory/host_vars/<your-domain>/vars.yml` file to your liking.

7. Run the playbook:

   `ansible-playbook -i inventory/hosts rookery.yml`

   _Note_: if you are not the root user or don't have password-less sudo, use this command:

   `ansible-playbook -i inventory/hosts rookery.yml --become --ask-become-pass`

   _Note_: if you haven't set up ssh keys[^1], and ssh using a password, use the command:

   `ansible-playbook -i inventory/hosts rookery.yml --become --ask-pass --ask-become-pass`

   [Full ansible command-line docs](https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html)

   If the command above fails, you may need to comment out this line In the ansible.cfg file:

   `interpreter_python=/usr/bin/python3`

[^1]: To create an ssh key pair with your host environment, you can follow the [instructions here](https://www.ssh.com/academy/ssh/keygen#copying-the-public-key-to-the-server), and then copy the key to your host server.

## Uninstall

`ansible-playbook -i inventory/hosts uninstall.yml --become`

## License

- [AGPL License](/LICENSE)

