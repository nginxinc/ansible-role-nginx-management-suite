<!-- [![Ansible Galaxy](https://img.shields.io/badge/galaxy-nginxinc.nginx-5bbdbf.svg)](https://galaxy.ansible.com/nginxinc/nginx_management_suite) -->
[![Molecule CI/CD](https://github.com/nginxinc/ansible-role-nginx-management-suite/workflows/Molecule%20CI/CD/badge.svg)](https://github.com/nginxinc/ansible-role-nginx-management-suite/actions/workflows/molecule.yml/badge.svg)
[![License](https://img.shields.io/badge/License-Apache--2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

# Ansible NGINX Management Suite Role

This role only installs NGINX Management Suite (NMS).

**Note:** This role is still in active development. There may be unidentified issues and the role variables may change as development continues.

## Requirements

1. NGINX Management Suite License Files
2. [NGINX Ansible Role (**nginxinc.nginx**)](https://github.com/nginxinc/ansible-role-nginx)

### NGINX Management Suite Certificate Files

Installing NMS requires the NMS certificate files to access the repository. Log in to [MyF5](https://account.f5.com/myf5) or follow the link in the trial activation email to download the NMS repo **.crt** and **.key** files:

* nginx-mgmt-suite-trial.key
* nginx-mgmt-suite-trial.crt

**NOTE:** Be sure to rename these files to `nginx-repo.key` and `nginx-repo.crt`, respectively.

### NGINX Instance

NMS requires an NGINX instance, either NGINX OSS or NGINX Plus as a frontend only. This role handles this by defining a dependency to the [NGINX Ansible Role](https://github.com/nginxinc/ansible-role-nginx), named **nginxinc.nginx**. Because of this dependance, you can set variables related to **nginxinc.nginx** when using this role. For example, `nginx_type` is an **nginxinc.nginx** variable that can be [set like how you would any other Ansible variable](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html#where-to-set-variables). So if your playbook defines `nginx_type: plus`, this NMS role will call the **nginxinc.nginx** role which will install NGINX Plus. Refer to the [Ansible Role NGINX](https://github.com/nginxinc/ansible-role-nginx) for more details.

Main difference between using NGINX OSS or NGINX Plus depends on which [Authentication Option](https://docs.nginx.com/nginx-management-suite/admin-guides/access-control/configure-authentication/#auth-options) you plan to use.

### Ansible

* This role is developed and tested with [maintained](https://docs.ansible.com/ansible/devel/reference_appendices/release_and_maintenance.html) versions of Ansible core (above `2.12`).
* This role was developed and tested using **nginxinc.nginx** version **0.24.0**.
  * UPDATE 6/24/24: Use the edge *nginxinc.nginx* version, example of `requirements.yml` shown [here](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/8feff2413ca3b5281a4002dcd6518e38effcf7e4/.github/workflows/requirements/requirements_ansible.yml#L3-L6)
* When using this role, you will also need to install the following collections below. Additional information installing these collections is below in the [Installation](#installation) section.
  * ansible.posix
  * community.general
  * community.crypto
  * community.docker (Only required if you plan to use Molecule)

* You will need to run this role as a root user using Ansible's `become` parameter. Make sure you have set up the appropriate permissions on your target hosts.
* Instructions on how to install Ansible can be found in the [Ansible website](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#upgrading-ansible-from-version-2-9-and-older-to-version-2-10-or-later).

### Jinja2

* This role uses Jinja2 templates. Ansible core installs Jinja2 by default, but depending on your install and/or upgrade path, you might be running an outdated version. The minimum version of Jinja2 required for the role to properly function is `3.1`.
* Instructions on how to install Jinja2 can be found in the [Jinja2 website](https://jinja.palletsprojects.com/en/2.11.x/intro/#installation).

### Molecule (Optional)

You will want to use this if you are making contributions to this ansible role.

* Molecule is used to test the various functionalities of the role. The recommended version of Molecule to test this role is `4.0.1`.
* Instructions on how to install Molecule can be found in the [Molecule website](https://molecule.readthedocs.io/en/latest/installation.html). *You will also need to install the Molecule Docker driver.*
* To run the Molecule tests, you must copy your NMS license to the role's [`files/license`](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/files/license/) folder.

  You can alternatively add your NGINX Management Suite repository certificate and key to the local environment. Run the following commands to export these files as base64-encoded variables and execute the Molecule tests:

  ```bash
  export NGINX_CRT=$( cat <path to your certificate file> | base64 )
  export NGINX_KEY=$( cat <path to your key file> | base64 )
  molecule test -s plus
  ```

## Usage

Take these steps in order to install NGINX Management Suite (nms) using this ansible role.

### Create Inventory File

You will want to create an inventory file, `inventory`, with the following contents.

```ini
[nms]
<hostname> ansible_user=<adminUserName>  ansible_become=yes
```

### Install Required Roles and Collections

You will want to install the package requirements this role requires. Create a `requirements.yml` file with the below content

```yaml
---
roles:
  - name: nginxinc.nginx_management_suite
    version: 0.3.0
collections:
  - name: ansible.posix
    version: 1.5.1
  - name: community.general
    version: 6.4.0
  - name: community.crypto
    version: 2.11.0
  - name: community.docker # Only required if you plan to use Molecule (see below)
    version: 3.4.2
```

Use the command to install the ansible role and collections.

```shell
ansible-galaxy install -r requirements.yml
```

If you already have these installed but need to update to newer versions, use the below command.

```shell
ansible-galaxy install -fr requirements.yml
```

### Move NGINX Certificates to a Known Location

In this example here, we will move the NGINX certificates to the same directory where I will be creating the NMS install playbook file.

### Create Playbook

Create a playbook file, `nms-install.yml`, using the following example. Here, we are installing NMS with NGINX Plus.

Be sure to specify the path where your NGINX certificates are located. In the example here, they are in the same path as this playbook.

```yaml
- name: Install NGINX Management Suite
  hosts: nms

  tasks:
    - name: Install NMS
      ansible.builtin.include_role:
        name: nginxinc.nginx_management_suite
      vars:
        nms_setup: install
        nms_user_name: admin
        nms_user_passwd: default
        nginx_type: plus
        nginx_selinux: true
        nginx_selinux_enforcing: false
        nginx_license:
          certificate: nginx-repo.crt
          key: nginx-repo.key
```

### Install NMS

Run the following command to run the playbook which will install NMS.

```shell
ansible-playbook -i inventory nms-adm-install.yml
```

## Using Latest Edge of NMS Ansible Role, aka the `main` Branch

There is a couple methods if you want to use the latest edge from this role.

1. Use the following snippet in your `requirement.yml`.

    ```yaml
    roles:
      - src: https://github.com/nginxinc/ansible-role-nginx-management-suite.git
        version: main
    ```

1. Use `git clone https://github.com/nginxinc/ansible-role-nginx-management-suite.git` to pull the latest edge commit (the `main` branch) of the role from GitHub.

## Platforms

This Ansible role supports all platforms supported by [NGINX Management Suite](https://docs.nginx.com/nginx-management-suite/overview/tech-specs/#supported-distributions):

### NGINX Management Suite

```yaml
Amazon Linux 2:
  - any
CentOS:
  - 7.4+
Debian:
  - buster (10)
  - bullseye (11)
Oracle Linux:
  - 7.4+
  - 8
Red Hat:
  - 7.4+
  - 8
  - 9
Ubuntu:
  - bionic (18.04)
  - focal (20.04)
  - jammy (22.04)
```

**Note:** You can also use this role to install NGINX Management Suite on compatible yet unsupported platforms at your own risk.

## Role Variables

This role has multiple variables. The descriptions and defaults for all these variables can be found in the **[`defaults/main/`](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/defaults/)** folder in the following file:

| Name | Description |
| ---- | ----------- |
| **[`main.yml`](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/defaults/main.yml)** | NMS installation variables |

Similarly, descriptions and defaults for preset variables can be found in the **[`vars/`](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/vars/)** folder in the following file:

| Name | Description |
| ---- | ----------- |
| **[`main.yml`](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/vars/main.yml)** | List of supported NMS installation variables |

## Example Playbooks

Working functional playbook examples can be found in the **[`molecule/`](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/molecule/)** folder in the following files:

| Name | Description |
| ---- | ----------- |
| **[`default/converge.yml`](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/molecule/default/converge.yml)** | Install NGINX OSS and NMS |
| **[`plus/converge.yml`](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/molecule/plus/converge.yml)** | Install NGINX Plus and NMS |
| **[`upgrade/converge.yml`](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/molecule/upgrade/converge.yml)** | Upgrade NMS |
| **[`modules/converge.yml`](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/molecule/modules/converge.yml)** | Install NGINX OSS and NMS & the API Connectivity Manager module |
| **[`service-stopped/converge.yml`](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/molecule/service-stopped/converge.yml)** | Install NGINX OSS and NMS, allow services to be in the chosen state |

Do note that if you install this repository via Ansible Galaxy, you will have to replace the role variable in the sample playbooks from `ansible-role-nginx-management-suite` to `nginxinc.nginx_management_suite`.

## Other NGINX Ansible Collections and Roles

You can find the Ansible NGINX Core collection of roles to install and configure NGINX Open Source, NGINX Plus, and NGINX App Protect [here](https://github.com/nginxinc/ansible-collection-nginx).

You can find the Ansible NGINX configuration role to configure NGINX [here](https://github.com/nginxinc/ansible-role-nginx-config).

You can find the Ansible NGINX Unit role to install NGINX Unit [here](https://github.com/nginxinc/ansible-role-nginx-unit).

## License

[Apache License, Version 2.0](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/LICENSE)

## Author Information

[John Wong](https://github.com/jswongf5)

[Alessandro Fael Garcia](https://github.com/alessfg)

&copy; [F5, Inc.](https://www.f5.com/) 2023
