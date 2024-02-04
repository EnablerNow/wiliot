# Wiliot Project Setup

## Clone the Repository

To get started, clone the Wiliot project repository from GitHub:

```bash
git clone https://github.com/EnablerNow/wiliot


Project Overview
This repository contains the following components:

Terraform Code: Infrastructure as Code (IaC) written in Terraform to create the AWS infrastructure.

Python Server and Dockerfile: A Python server application with a Dockerfile to build the application container.

Helm Charts: Helm charts are provided for deploying the application.

Requirements
Before you begin, ensure that you have the following software and configurations in place:

Docker: Install Docker on your system.

Terraform: Make sure you have Terraform installed to manage infrastructure.

kubectl: Install kubectl to interact with Kubernetes clusters.

Helm: Helm is required for deploying the application using Helm charts.

AWS CLI: Configure the AWS CLI with your AWS credentials to apply Terraform configurations and interact with Kubernetes and Helm.

Running the Project
Follow these steps to set up and run the project:

Make the init.sh script executable:

chmod +x init.sh
./init.sh

The init.sh script automates the following tasks:

Initializes the Terraform workspace.
Applies the Terraform configuration to create the AWS infrastructure.
Builds a Docker image for the Python server application.
Deploys the application to Kubernetes using Helm charts.
Make sure to review the script for additional details and customizations.

With these steps completed, you will have the infrastructure and application up and running. You can access the deployed application as needed.

In the end the scipt will output the external url of the app
