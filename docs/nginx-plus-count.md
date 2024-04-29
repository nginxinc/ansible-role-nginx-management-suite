# NGINX Plus Counting

You can use this role to help count the number of NGINX Plus instance you have.

## Requirement

You will also need to install the following collection in order to use the example playbooks for counting NGINX Plus instances.

```yaml
collections:
  - name: https://github.com/TuxInvader/ansible_collection_nginx_management_suite.git
    type: git
    version: main
```

## Example NGINX Plus Count Playbook

Example playbooks are also tested as a part of this role and can be found in the table below.

| Name | Description |
| ---- | ----------- |
| **[`plus-count-ubuntu/converge.yml`](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/molecule/plus-count-ubuntu/converge.yml)** | Install NMS and NGINX Agent on NGINX Plus instances using an Ubuntu NMS Host |
| **[`plus-count-rhel/converge.yml`](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/molecule/plus-count-rhel/converge.yml)** | Install NMS and NGINX Agent on NGINX Plus instances using a RHEL NMS Host |
| **[`plus-count-upgrade/converge.yml`](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/molecule/plus-count-rhel/converge.yml)** | Upgrade NMS and NGINX Agent on NGINX Plus instances using aN Ubuntu NMS Host |
