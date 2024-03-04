# Week 2: Deploy Ansible on EC2 and push the configuration via it to Nexus

This repository contains Terraform configurations and scripts to deploy Ansible on an AWS EC2. In the other hand we configure the Nexus repository via Ansible to proxy various Linux distributions.

## Disclaimer

**Important: This repository is intended for test development purposes only. It is not recommended to use this setup in a production environment due to security concerns. Specifically, the configuration script utilizes plain text passwords, and the current EC2 setup does not enforce the use of key pairs for SSH access. Before using this project in a production environment, you must modify it.**

## Overview

## Repository Structure

## Variables

## Usage

## Customization

You can customize your deployment by modifying the `.tf` files with your desired configurations. Ensure you review and update the variables to match your requirements.

## Security Notice

Ensure that your AWS credentials are securely stored and that you follow the principle of least privilege when setting up your Terraform AWS provider.

## Contributions

Contributions to this project are welcome. Please fork the repository, make your changes, and submit a pull request.

## License

This project is open source and available under the [MIT License](LICENSE).
