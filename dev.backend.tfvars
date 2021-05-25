#-----------------------------------------------------------
# Provider Authentication 
#----------------------------------------------------------

terraform {
    required_providers {
        databricks = {
            source     = "databrickslabs/databricks"
            version  = "0.2.5"
        }
        azurerm    = {
            source  = "hashicorp/azurerm"
            version = "=2.46.0"
        }
    }
    backend "azurerm" {
    #container_name should be passed as -backend-config param
    #Change storage account name for prod
    resource_group_name     = "tf_statefile_rg"
    storage_account_name    = "tfstatefilestorage"
    container_name          = "dev"
    key                     = "terraform.tfstate"

    }
    
}

variable "client_secret" {} # Variable to store SP's password
variable "client_id" {}     # Application ID
variable "subscr_id" {}     # Subscription ID
variable "tenant_id" {}     # Tenant ID

provider "azurerm" {
    subscription_id     = var.subscr_id
    client_id           = var.client_id
    client_secret       = var.client_secret
    tenant_id           = var.tenant_id
    features { }
    
}

