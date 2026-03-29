provider "azurerm" {
  features {
    
  }
}
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "> 4.0"
    }
  }
    backend "azurerm" {
    resource_group_name   = "tf-rg"
    storage_account_name  = "tfstorage1103"
    container_name        = "tfstate"
    key                   = "aks.tfstate"
}
}

resource "azurerm_resource_group" "rg" {
    name     = var.resource_group_name
    location = var.Location
}
resource "azurerm_kubernetes_cluster" "AKS" {
    name                = var.AksClusterName
    resource_group_name = azurerm_resource_group.rg.name
    location            = azurerm_resource_group.rg.location
  dns_prefix = "aksdevdemo"

    default_node_pool {
        name       = "nodepool1"
        node_count = var.AksNodeCount
        vm_size    = var.VM_size
    }
  identity {
    type = "SystemAssigned"
    }

}
data "azurerm_container_registry" "acr" {
  name                = var.acrname
  resource_group_name = var.acrrgname
}
#Role assignment for AKS to pull images from ACR
resource "azurerm_role_assignment" "acrpull" {
  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.AKS.kubelet_identity[0].object_id
  depends_on = [ azurerm_kubernetes_cluster.AKS ]
}
