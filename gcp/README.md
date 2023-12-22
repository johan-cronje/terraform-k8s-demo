# Provision a GKE Cluster

## Install / Configure Google Cloud CLI

```bash
brew install --cask google-cloud-sdk
gcloud init
```

## Set up Google Cloud Credentials

Add your account to the Application Default Credentials (ADC). This will allow Terraform to access these credentials to provision resources on GCloud.
```bash
gcloud auth application-default login
```
## Set up Terraform variables

Update the values in the `terraform.tfvars` file. The **credentials_file** value is the name of the key file generated for the Service Account. Terraform will use these values while provisioning your resources:

```
# terraform.tfvars
credentials_file = "myproject-123456-71a8166b55db.json"
project_id = "myproject-123456"
region     = "us-west1"
```

You can find the project your account is configured to with this command:
```bash
gcloud config get-value project
```

## Deploy the Kubernetes cluster to GKE

```bash
# change the current folder
cd gcp

# initialize Terraform 
terraform init

# OPTIONAL: preview the resources Terraform will create
terraform plan

# Create the resources
terraform apply -auto-approve
```
Once complete, the values specified in the `output.tf` script will be displayed:

```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

kubernetes_cluster_host = "35.232.196.187"
kubernetes_cluster_name = "selected-trout-gke"
project_id = "selected-trout"
region = "us-west1"
```

## Configure kubectl
Once the GKE cluster has been provisioned, configure [kubectl](https://kubernetes.io/docs/reference/kubectl/) to deploy workloads to the cluster

Run the following command to retrieve the access credentials for the cluster and automatically configure kubectl:
```bash
gcloud container clusters get-credentials \
 $(terraform output -raw kubernetes_cluster_name) \
 --region $(terraform output -raw region)
```

## Deploy workloads to the Kubernetes cluster
At this point kubectl is ready to deploy workloads to the cluster

## Destroy the Kubernetes cluster
```bash
terraform destroy -auto-approve
```