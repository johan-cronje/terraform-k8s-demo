variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
  type = string
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
  type = string
}

variable "location" {
  description = "Azure Region"
  type = string
  default = "West US 2"
}

variable "environment" {
  description = "Environment tag value"
  type = string
  default = "Demo"
}