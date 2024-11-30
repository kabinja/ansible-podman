# Ansible

## Setting up the environment

Once ansible is installed, all the requriments for the build need to be installed. Here, we need two collections from ansible galaxy: `ansible.posix`and `containers.podman`. They are referenced in the requirements files and can be installed using the command below.

```sh
ansible-galaxy install -r requirements.yml

```

## Running the playbook

It is now time to run the playbook. To ensure that the endpoint is always accessible, we opted for a rooted deployment. As such, the systemd unit is deployed under `/etc/systemd/system`. This is why we need the become at the bebinning of the playbook. To execute the playbook, run the command below.

```sh
ansible-playbook --ask-become-pass deploy.yaml

```
