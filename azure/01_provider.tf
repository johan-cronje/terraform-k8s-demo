terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.67"
    }
  }

  required_version = "~> 1.3"
}

provider "azurerm" {
  features {}
}
