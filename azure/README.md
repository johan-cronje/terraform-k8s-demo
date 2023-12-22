# Provision an AKS Cluster

## Install / Configure Azure CLI

```bash
brew install azure-cli
az login
```

## Set up Azure Credentials

Create Active Directory service principal for automation authentication
```bash
az ad sp create-for-rbac
```
The output of the command will look like this:
```json
{
  "appId": "...<obfuscated...>",
  "displayName": "azure-cli-2023-12-02-20-55-28",
  "password": "...<obfuscated...>",
  "tenant": "...<obfuscated...>"
}
```

## Set up Terraform variables

Update the values in the `terraform.tfvars` file with the **appId** and **password** values displayed in the output. Terraform will use these values to authenticate to Azure before provisioning your resources.

```
# terraform.tfvars
appId    = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
password = "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
```

## Deploy the Kubernetes cluster to AKS

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
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

kubernetes_cluster_name = "selected-trout-aks"
resource_group_name = "selected-trout-rg"
```

## Configure kubectl
Once the AKS cluster has been provisioned, configure [kubectl](https://kubernetes.io/docs/reference/kubectl/) to deploy workloads to the cluster

Run the following command to retrieve the access credentials for the cluster and automatically configure kubectl:
```bash
az aks get-credentials \
 --resource-group $(terraform output -raw resource_group_name) \
 --name $(terraform output -raw kubernetes_cluster_name)
```

## Deploy workloads to the Kubernetes cluster
You can now use kubectl to manage your cluster and deploy Kubernetes configurations to it.

## OPTIONAL: Access Kubernetes Dashboard
Visit the Azure Portal's Kubernetes resource view by running the following command to generate the Azure portal link:
```bash
az aks browse \
 --resource-group $(terraform output -raw resource_group_name) \
 --name $(terraform output -raw kubernetes_cluster_name)
```

## Destroy the Kubernetes cluster
```bash
terraform destroy -auto-approve
```