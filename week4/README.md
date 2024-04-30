# Week 4: Automating Linux Distribution Updates with Ansible and Monitoring with Splunk

## Description

This project automates the update process the most popular Linux distributions (RedHat and Debian based) and allows monitoring of these updates via a Splunk dashboard. **Please note, all resources from Week 3 will be replaced. Ensure you run `terraform destroy` before proceeding to clean up existing resources.**

## Disclaimer

**Important: This repository is intended for developmental testing purposes only and should not be used in production environments. The configuration script employs plain text passwords, and the current EC2 setup does not enforce SSH key pairs, which is a security risk. Modifications are required before deploying this project in a production setting.**

## Motivation

### Automating Updates
Automating boring stuff is cool and essential, especially in large environments. Therefore, I decided to automate the updating process across all Linux servers. Initially, I wrote an Ansible playbook to accomplish this task, but running the playbook manually became tedious as well. To address this, I added the playbook to crontab to execute at regular intervals.

### Monitoring with Splunk
However, a new challenge arose: how to determine if any servers encountered issues or whether the playbook ran successfully. To solve this, I configured the playbook to write its results to a file and monitored it using Splunk, a powerful monitoring and log management tool. This allowed me to create a dashboard to visualize the results of the updating process.

### Alerting and Troubleshooting
Furthermore, I set up alerts for various scenarios. For example, if no events were received, it indicated that the playbook did not run properly. Similarly, if the cache update failed, an email alert would be sent to the person in charge. These alerts helped in identifying and addressing issues promptly.

### Benefits of the Dashboard
Having a dashboard provides a comprehensive history of the updating process across the entire environment. It enables you to track server accessibility over time, identify servers that failed to boot normally after an Ansible-initiated reboot, and gain valuable insights into the overall update process. This historical data can be invaluable for troubleshooting, auditing, and ensuring the smooth operation of your Linux servers."

## Overview

This project streamlines the updating process for Linux instances by leveraging a Nexus repository as a centralized source for installation files and packages. The supported Linux distributions include Ubuntu, Debian, CentOS, and Red Hat Enterprise Linux.

The project consists of the following key components:

1. Nexus Repository: A private Nexus repository is set up to store and manage installation files and packages required for updating the Linux instances. This ensures a reliable and controlled source for the necessary files.

1. Splunk Installation: An Ansible playbook is used to install Splunk on a dedicated instance within a private subnet. The Splunk instance retrieves the required installation files from the Nexus repository, ensuring a secure and efficient installation process.

3. Ansible-based Updates: Ansible is employed to automate the updating process for all the Linux instances. It executes the necessary tasks to update the instances and logs the results for further analysis and monitoring.

4. Splunk Dashboard: The update statuses and outcomes are visualized through a comprehensive dashboard in Splunk. This dashboard provides a clear and centralized view of the update statuses across different environments, enabling easy monitoring and troubleshooting.

By leveraging a Nexus repository, automating updates with Ansible, and visualizing the results through Splunk, this project simplifies the management and monitoring of Linux instance updates. It ensures a consistent and controlled updating process while providing valuable insights into the update statuses across the entire environment."

## Repository Structure

- **Terraform files**: Essential files for AWS resource creation.
  - `ec2-ansible`: Creates an EC2 instance and bootstraps the Ansible installation using a shell script.
  - `ec2-nexus`: Sets up an EC2 instance with Nexus OSS using Docker Compose.
  - `ec2-splunk`: Deploys an EC2 instance for Splunk.
  - `ec-linux-instances`: Creates various Linux distribution instances for update testing.
  - `network-vpc`: Establishes a dedicated VPC.
  - `network-security-groups`: Configures necessary security groups.
  - `network-alb`: Deploys an Application Load Balancer in front of the Splunk instance.
  - `data-sources`: Contains all necessary data sources for AZs and AMIs.
  - `local`: Defines tags, environments, and Linux distributions.
  - `variables`: Manages all Terraform variables.
  - `outputs`: Displays the ALB URL and Nexus repository URL.

- **Scripts**: Scripts for proper instance configuration.
  - `config-ansible`: Installs Ansible.
  - `config-nexus`: Sets up Docker and initiates Nexus OSS via Docker Compose.
  - `config-linux-instances`: Configures instances for username and password access and enables PasswordAuthentication.

- **ansible-project/**: Contains playbooks and roles for various configurations.
  - `01-nexus-config`: Configures Nexus OSS as a proxy repository.
  - `02-repo-config`: Sets up Linux instances to use the Nexus repository for updates.
  - `03-splunk-config`: Installs Splunk and starts it as a service, including an app for update monitoring.
  - `04-update-linux`: Updates various Linux distributions with customizable settings, such as conditional reboots.

## Usage

### Prerequisites

Before you can use these configurations, you need to have the following:

- An AWS account with appropriate permissions to create resources such as VPC, EC2 instances, and security groups.
- Terraform installed on your local machine. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
- AWS CLI installed and configured on your local machine. [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
- Your AWS credentials, including your Access Key and Secret Access Key, are configured for use with the AWS CLI or Terraform. These credentials should be associated with a user who has the necessary permissions to deploy and manage the AWS resources.

### Setting Up AWS Credentials

1. Log in to the AWS Management Console.
2. Navigate to the IAM (Identity and Access Management) service.
3. Create a new IAM user or use an existing one, and ensure programmatic access is enabled for the user. For more information on creating IAM users, refer to the [IAM User Creation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)
4. Attach policies that grant the user sufficient permissions to create, modify, and delete resources as required by the Terraform configurations. You can create custom policies or use AWS managed policies such as "AmazonEC2FullAccess" or "AmazonVPCFullAccess" depending on your requirements.
5. On the final screen, you will be provided with an Access Key ID and Secret Access Key for the user. Store these credentials securely, as they provide programmatic access to your AWS resources.
6. Configure the AWS CLI with the credentials by running `aws configure` and entering the Access Key ID and Secret Access Key when prompted. Alternatively, you can set up AWS credentials using environment variables or AWS credentials files.

### Deployment with Terraform

    ```bash
    git clone https://github.com/mzandinia/sample-project-on-AWS
    cd sample-project-on-AWS/week4
    terraform init
    terraform plan
    terraform apply
    ```
   ![alt text](./images/aws%2001.png)

   ![alt text](./images/aws%2002.png)

   ![alt text](./images/aws%2003.png)

   ![alt text](./images/aws%2004.png)

   ![alt text](./images/aws%2005.png)

   ![alt text](./images/aws%2006.png)

   After this stage, all necessary resources will be created. At the end terraform output will provide you three values:

   1- Nexus initial password

   2- Load Balancer address

   3- Nexus login URL

   ![alt text](./images/aws%2007.png)

### Login to Nexus Repository

   At this moment, log in to Nexus via the URL and password that were provided to you in the Terraform output.

   ![Nexus login page](./images/aws%2008.png)

   Click on the "Sign In" button on the top right of the screen and enter the `admin` user and the password provided to you in the last step.

   ![Nexus login form](./images/aws%2009.png)

   Click `Next` to continue.

   ![Nexus password change prompt](./images/aws%2010.png)

   Enter a new strong password.

   ![Nexus new password form](./images/aws%2011.png)

   Choose `enable anonymous access` and then click `next` to continue. Enabling anonymous access allows unauthenticated users to access certain repositories or resources.

   ![Nexus anonymous access settings](./images/aws%2012.png)

   Choose `Finish` to complete the login and configuration process.

   ![Nexus setup complete](./images/aws%2013.png)

### Upcoming Steps
In the following steps, we will:

1- Configure Nexus and Linux instances to use it as a default repository.<br>
2- Install and configure Splunk<br>
3- Update all the instances<br>

Afterward, the Splunk dashboard will provide a comprehensive view of the system.

### Step1: Configure Nexus by Ansible

   To configure Nexus using Ansible, first log in to the Nexus server via SSH using the `demouser` username and `changeme` password.

   ![SSH login to Nexus server](./images/aws%2014.png)

   Next, log in to the Ansible server via SSH using the same `demouser` username and `changeme` password. Ansible will be used to automate the configuration of Nexus.

   ![SSH login to Ansible server](./images/aws%2015.png)

   Clone the repository containing the Ansible playbooks:

   `git clone https://github.com/mzandinia/sample-project-on-AWS.git`

   ![Cloning the repository](./images/aws%2016.png)

   Navigate to the ansible-project directory:

   `cd sample-project-on-AWS/week4/ansible-project`

   ![Navigating to the ansible-project directory](./images/aws%2017.png)

   Run the ansible-playbook command to execute the nexus-config.yml playbook, which configures the Nexus OSS repository. When prompted, enter the new password you configured for Nexus during the login process.<br>
   `ansible-playbook 01-nexus-config/nexus-config.yml`

   ![Running the Ansible playbook](./images/aws%2020.png)

   ![Ansible playbook output](./images/aws%2021.png)

   After the playbook execution completes, you can verify that the appropriate repositories are configured in Nexus.

   ![Configured repositories in Nexus](./images/aws%2022.png)

   The nexus-config.yml playbook automates the configuration of Nexus, setting up the necessary repositories for the project.

### Step 2: Configure Linux Instances to use the nexus repo

   To configure the Linux instances to use the Nexus repository, run the following command:

   `ansible-playbook 02-repo-config/repo-config.yml`

   ![Running the repo-config.yml playbook](./images/aws%2023.png)

   The `repo-config.yml` playbook automates the configuration of the Linux instances to use the Nexus repository. It updates the package manager configuration files on each instance to point to the Nexus repository, ensuring that the instances will fetch packages and dependencies from Nexus instead of the default public repositories.

### Step3: Install Splunk and Special app to view the results of the updates

   Splunk is a powerful log management and analysis tool that can help you monitor and visualize the results of the updates performed on the Linux instances. To install Splunk and set up a custom dashboard, run the following command:

   `ansible-playbook 03-splunk-config/splunk-config.yml`

   ![Running the splunk-config.yml playbook](./images/aws%2024.png)

   ![Result of execution of the splunk-config.yml playbook](./images/aws%2025.png)

   The splunk-config.yml playbook automates the installation of Splunk on a designated instance and configures it to collect logs from the Linux instances. It also sets up the necessary Splunk configurations and forwards the logs to the Splunk instance for centralized monitoring.

   The linux-update app includes pre-configured reports and alerts that help you track the progress of the updates, identify any issues or failures, and ensure that all instances are successfully updated. The dashboard provides a comprehensive view of the update process, making it easier to monitor and manage the updates across multiple instances.

   By using Splunk and the linux-update app, you can gain valuable insights into the update process, quickly identify and troubleshoot any problems, and ensure that your Linux instances are up-to-date and secure.

### Step4: Updating Linux Instances

   Keeping your Linux instances up-to-date is crucial for maintaining system security, stability, and performance. This step focuses on updating the Linux instances using Ansible, with different update strategies and reboot behaviors.<br>
   The update process is divided into four plays based on two factors:

   1- How to update the OS: Update all packages or exclude some packages

   2- How to reboot the server: Just check the reboot status or automatically reboot using Ansible

|              | Update | Reboot | Associated Variables |
|    :---:     |      :---:     |     :---:     |     :---     |
| 1 | All OS and other packages | just check by Ansible | <ul><li>exclude = 0</li><li>reboot = 0</li></ul> |
| 2 | All OS and other packages | automatically by Ansible | <ul><li>exclude = 0</li><li>reboot = 1</li></ul> |
| 3 | Some packages exclude from update | just check by Ansible | <ul><li>exclude = 1</li><li>reboot = 0</li></ul> |
| 4 | Some packages exclude from update | automatically by Ansible | <ul><li>exclude = 1</li><li>reboot = 1</li></ul> |

   To update all instances, run the following command:

   `ansible-playbook 04-update-linux/update-linux.yml`

   The `update-linux.yml` playbook handles the update process based on the specified variables, ensuring that the desired update strategy and reboot behavior are applied to each instance.

   ![Run the update-linux.yml playbook](./images/aws%2026.png)

   ![results of the update-linux.yml playbook](./images/aws%2027.png)

   After executing the playbook, use the ALB load balancer address to log into Splunk with the username `admin` and password `changeme`. The Splunk dashboard provides a centralized view of the update process, allowing you to monitor the progress and view the results.

   ![Splunk login page](./images/aws%2028.png)

   Click on the `"Linux Update Dashboard"` to access the custom dashboard created by the linux-update app.

   ![Linux Update Dashboard](./images/aws%2030.png)

   This dashboard presents a comprehensive overview of the update results and various configurations.

   ![Linux OS update result](./images/aws%2031.png)

   The `linux-update` app also includes predefined reports and alerts to help you identify and troubleshoot issues that may occur during the update process:

   **Reports:**

   ![Reports](./images/aws%2032.png)

   - `Cache Update Failure`: Triggers if the cache update process fails for any reason.
   - `Host Unreachable`: Alerts if any host becomes unreachable during playbook execution.
   - `Update Result Failure`: Indicates if there is a problem during the update operation.

   **Alerts:**

  ![alt text](./images/aws%2033.png)

  -`Playbook Execution Failure`: Triggers if there are no logs, suggesting that the playbook was not executed.

  -`Reboot Failure`: **Critical alert** if an instance fails to come back up after an Ansible-initiated reboot.

  -`Server(s) must be reboot`: Notifies if some servers require manual rebooting.

  By leveraging Ansible, Splunk, and the linux-update app, you can efficiently manage and monitor the update process across your Linux instances, ensuring system security and stability.

## Contributions

Contributions to this project are welcome. Please fork the repository, make your changes, and submit a pull request.

## License

This project is open source and available under the [MIT License](LICENSE).
