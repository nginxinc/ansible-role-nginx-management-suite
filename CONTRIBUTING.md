# Contributing Guidelines

The following is a set of guidelines for contributing to the ansible_role_nginx_management_suite. We really appreciate that you are considering contributing!

#### Table Of Contents

[Getting Started](#getting-started)

[Contributing](#contributing)

[Code Guidelines](#code-guidelines)

* [Git Guidelines](#git-guidelines)
* [Ansible Guidelines](#ansible-guidelines)

[Code of Conduct](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/CODE_OF_CONDUCT.md)

## Getting Started

Follow our [Installation Guide](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/README.md#Installation) to get the ansible_role_nginx_management_suite up and running.

### Project Structure

* The NGINX Management Suite Ansible role is written in `yaml` and supports NGINX Management Suite (NMS) Installation.
  * An NGINX Plus license is required in order to install NMS.
* The project follows the standard [Ansible role directory structure](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html):
  * The main code is found in [`tasks/`](https://github.com/nginxinc/ansible-role-nginx/blob/main/tasks/).
  * Variables can be found in [`defaults/main/`](https://github.com/nginxinc/ansible-role-nginx/blob/main/defaults/main/).
  * "Constant" variables can be found in [`vars/main.yml`](https://github.com/nginxinc/ansible-role-nginx/blob/main/vars/main.yml).
  * [Molecule](https://molecule.readthedocs.io/) tests can be found in [`molecule/`](https://github.com/nginxinc/ansible-role-nginx/blob/main/molecule/).
  * CI/CD is done via GitHub actions using the workflow files found in [`.github/workflows/`](https://github.com/nginxinc/ansible-role-nginx/blob/main/.github/workflows/).


<!-- ### Project Structure (OPTIONAL) -->

## Contributing

### Report a Bug

To report a bug, open an issue on GitHub with the label `bug` using the available bug report issue template. Please ensure the bug has not already been reported. **If the bug is a potential security vulnerability, please report using our security policy.**

### Suggest a Feature or Enhancement

To suggest a feature or enhancement, please create an issue on GitHub with the label `feature` or `enhancement` using the available feature request issue template. Please ensure the feature or enhancement has not already been suggested.

### Open a Pull Request

* Fork the repo, create a branch, implement your changes, add any relevant tests, submit a PR when your changes are **tested** and ready for review.
* Fill in [our pull request template](https://github.com/nginxinc/ansible-role-nginx-management-suite/blob/main/.github/pull_request_template.md).

Note: if you'd like to implement a new feature, please consider creating a feature request issue first to start a discussion about the feature.

## Code Guidelines

### Ansible Guidelines

* You need an NGINX Plus licesnse in order to install NMS, you will need to procure an NGINX Plus license (check out the [NGINX Plus developer license FAQ](https://www.nginx.com/developer-license-faqs/) to find out how to request one).
* Run `molecule lint` over your code to automatically resolve a lot of `yaml` and Ansible style issues.
* Run `molecule test` on your code before you submit a PR to catch any potential issues. If you are testing a specific molecule scenario, run `molecule test -s <scenario>`.
* Follow these guides on some good practices for Ansible:
  * <https://www.ansible.com/blog/ansible-best-practices-essentials>
  * <https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html>

### Git Guidelines

* Keep a clean, concise and meaningful git commit history on your branch (within reason), rebasing locally and squashing before submitting a PR.
* If possible and/or relevant, use the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) format when writing a commit message, so that changelogs can be automatically generated
* Follow the guidelines of writing a good commit message as described here <https://chris.beams.io/posts/git-commit/> and summarised in the next few points:
  * In the subject line, use the present tense ("Add feature" not "Added feature").
  * In the subject line, use the imperative mood ("Move cursor to..." not "Moves cursor to...").
  * Limit the subject line to 67 characters or less.
  * Limit the rest of the commit message to 72 characters or less.
  * Reference issues and pull requests liberally after the subject line.
  * Add more detailed description in the body of the git message (`git commit -a` to give you more space and time in your text editor to write a good message instead of `git commit -am`).
