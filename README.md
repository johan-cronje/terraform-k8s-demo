# terraform-k8s-demo

This repository contains HashiCorp [Terraform](https://www.terraform.io/) scripts to create a Kubernetes cluster on the following cloud platforms:

| Cloud Platform | k8s Service | Terraform Folder |
| --- | --- | --- |
| AWS | EKS (Elastic Kubernetes Service)  | `aws` |
| Azure | AKS (Azure Kubernetes Service | `azure` |
| Google Cloud | GKE (Google Kubernetes Engine) | `gcp` |

## Prerequisites

In order to run any of the demos, you will need to install the following software. Each cloud platform require's that it's CLI be installed as detailed in the READMEs in each folder.

Install Terraform (on macOS):
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

Install kubectl (on macOS):
```bash
brew install kubectl
```