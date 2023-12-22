# Provision an EKS Cluster

## Install AWS CLI

```bash
brew install awscli
```

## Set up the AWS CLI

After installation you will need to [Set up the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html)

## Set up Terraform variables

Update the values in the `terraform.tfvars` file. Terraform will use these values while provisioning your resources:
```
# terraform.tfvars
region       = "..<aws region>.."
```

## Deploy the Kubernetes cluster to EKS

> [!NOTE]
> The Terraform configuration defines a new VPC in which to provision the cluster using the public [EKS module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) to create the required resources. This includes Auto Scaling Groups, security groups, and IAM Roles and Policies.

```bash
# change the current folder
cd aws

# initialize Terraform 
terraform init

# OPTIONAL: preview the resources Terraform will create
terraform plan

# Create the resources
terraform apply -auto-approve
```

Once complete, the values specified in the `output.tf` script will be displayed:
```
Apply complete! Resources: 63 added, 0 changed, 0 destroyed.

Outputs:

cluster_endpoint = "https://128CA2A0D737317D36E31D0D3A0C366B.gr7.us-west-2.eks.amazonaws.com"
cluster_name = "selected-trout-eks"
cluster_security_group_id = "sg-0f836e078948afb70"
region = "us-west-2"
```

## Configure kubectl
Once the EKS cluster has been provisioned, configure [kubectl](https://kubernetes.io/docs/reference/kubectl/) to deploy workloads to the cluster

Run the following command to retrieve the access credentials for your cluster and configure kubectl
```bash
 aws eks --region $(terraform output -raw region) \
  update-kubeconfig \
  --name $(terraform output -raw cluster_name)
```

## Deploy workloads to the Kubernetes cluster
You can now use kubectl to manage your cluster and deploy Kubernetes configurations to it.

## Destroy the Kubernetes cluster
```bash
terraform destroy -auto-approve
```