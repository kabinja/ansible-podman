# Deploying podman containers using ansible

## Setting up the environment

```sh
ansible-galaxy install -r requirements.yml

```

## Running the playbook

```sh
ansible-playbook --ask-become-pass deploy.yaml --extra-vars "</path/to/mount>"

```
