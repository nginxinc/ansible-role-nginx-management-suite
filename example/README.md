# Ansible Playbook for NGINX Instance Manager and NGINX Agent Install

This is an example playbook that uses two new roles defined in this project for installing NIM and NGINX Agent.

## Prerequisites

- Below are the required dependencies required by this role.
```shell
ansible-galaxy install nginxinc.nginx
ansible-galaxy collection install community.general
```

There are 2 roles defined in this project (located in `roles` directory):
1. install-nim
2. install-agent


## Usage

1. Copy NGINX+ certs to this projects root. Or update the `nginx_license` certificate and keys paths located in `var/nginx-controller.yml` and `var/nginx-data.yml`
1. To modify NGINX Plus install/upgrade on the NMS Host, take a look at `var/nginx-controller.yml` to see variables.
2. To modify NGINX Plus install on the Data Plane Hosts, take a look at `var/nginx-data.yml` to see variables.
3. Anything related to NIM / NGINX Agent, look at variables in `var/nim.yml`. This is work in progress.
4. Update `inventory` file with your NMS Host and Data Plane Hosts.
5. Then run `ansible-playbook -i inventory main.yml`
