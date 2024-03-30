# Week 2: Deploy Ansible on EC2 and Configure Nexus

This week's project focuses on the deployment of Ansible on an AWS EC2 instance and the subsequent configuration of a Nexus repository using Ansible. This setup is designed to proxy various Linux distributions.

## Disclaimer

**Important: This repository is intended for test development purposes only. It is not recommended to use this setup in a production environment due to security concerns. Specifically, the configuration script utilizes plain text passwords, and the current EC2 setup does not enforce the use of key pairs for SSH access. Before using this project in a production environment, you must modify it.**

## Overview

In this phase of the project, we focus on deploying Ansible on an AWS EC2 instance and using it to configure a Nexus repository manager. The Nexus repository is set up to function as a proxy for various Linux distributions, facilitating the management of packages and their distribution.

## Repository Structure

- `nexus-configuration/`: Contains configuration files and scripts for setting up Nexus.
- `config_ansible.sh`: A shell script to install and configure Ansible on the EC2 instance.
- `t02-ec2instance05-ansible-host.tf`: Terraform configuration file for creating the EC2 instance that will host Ansible.
- `t03-securitygroups02.tf`: Terraform configuration file for setting up security groups related to the EC2 instance.
-
## Variables

By default, the EC2 instance type is set to `t3.medium`. However, this can be modified to suit different performance needs or cost considerations. Spot instances are utilized for cost efficiency.

## Usage

1. **Prepare the Environment**: Ensure that Terraform files are copied to `week1` to use the same VPC configuration.

2. **Terraform Deployment**:
    ```bash
    terraform apply
    ```
   This command deploys Ansible on the EC2 instance.

3. **Access Control**: Due to security precautions, the Ansible instance is not accessible from any location. Start by logging into the Nexus repository, and from there, access the Ansible instance via SSH.

4. **Ansible Configuration**:
    Navigate to the `nexus-configuration` directory and execute:
    ```bash
    ansible-playbook playbook.yml
    ```
   You will be prompted to enter the Nexus Repository password.

The configuration establishes blob stores for 'apt', 'yum', and 'raw' repositories and sets up proxy repositories for Ubuntu, Debian, AlmaLinux, RockyLinux, and Splunk. This approach ensures that we can install Splunk from its repository instead of using a prepared AMI, thereby demonstrating how to perform automatic updates for different Linux distributions.

## Contributions

Contributions to this project are welcome. Please fork the repository, make your changes, and submit a pull request.

## License

This project is open source and available under the [MIT License](LICENSE).
