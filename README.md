# eks-infra

This repository contains all the Terraform code required to provision a production-ready, highly-available EKS (Elastic Kubernetes Service) cluster on AWS.

The infrastructure is managed entirely as code and is deployed via GitHub Actions using a secure OIDC connection.

## Getting Started

```sh
aws eks update-kubeconfig --name eks-antoine --region eu-west-1
kubectl get nodes
```

## Overview

This project provisions the following core components:

* **VPC:** A new, custom VPC spanning 3 Availability Zones (`eu-west-1a`, `eu-west-1b`, `eu-west-1c`) with public and private subnets.
* **EKS Control Plane:** The managed Kubernetes "brain" (`eks-antoine`).
* **EKS Managed Node Group:** A group of EC2 worker nodes (`t3.medium`) running in the private subnets with auto-scaling capabilities (2 desired, 1-2 min/max).
* **Networking:** A single NAT Gateway for private subnets to access the internet (e.g., to pull Docker images).

## Prerequisites

### AWS S3 Backend
An S3 bucket must be created to store the Terraform state file.

1.  **Create an S3 Bucket** in `eu-west-1`.
2.  **Enable versioning** on the bucket.
3.  **Block all public access.**

### GitHub Actions OIDC Setup

This project uses AWS's OIDC functionality for secure, keyless authentication from GitHub Actions.

More information can be found on the [Configure AWS Credentials repository](https://github.com/aws-actions/configure-aws-credentials).

### GitHub Repository secrets

The GitHub Action is using the following variables as GitHub Repository secrets:

* `AWS_EKS_ADMIN_IAM_ROLE_ARN`: The ARN of a local IAM user to grant 'system:masters' access to the EKS cluster
* `AWS_REGION`: The default AWS region to use
* `AWS_ROLE_ARN`: The AWS IAM role to use for authentication
* `S3_TERRAFORM_BUCKET`: The AWS S3 Bucket name to store the Terraform state file
* `S3_TERRAFORM_STATE_KEY`: The key name of the Terraform state file

## Future Improvements

* Use [fck-nat](https://github.com/AndrewGuenther/fck-nat) to reduce NAT cost.
* Integrate [Infracost](https://github.com/infracost/infracost) to GitHub Actions.

## Troubleshooting

* https://repost.aws/knowledge-center/eks-cluster-connection
