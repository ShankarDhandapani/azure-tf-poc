terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
  }

  backend "azurerm" {
    resource_group_name  = "shankar-rg"
    storage_account_name = "apollopocshankar"
    container_name       = "tfstate"
    key                  = "akspoc.tfstate"
    subscription_id      = "145ccdc1-6c51-4e45-a04e-21bdea03d170"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "145ccdc1-6c51-4e45-a04e-21bdea03d170"
}