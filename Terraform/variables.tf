variable "resource_group_name" {
  description = "name of the resource group"
  type        = string
}
variable "Location" {
  description = "Azure region"
    type        = string
}
variable "AksClusterName" {
  description = "AKS cluster name"
  type = string
}
variable "AksNodeCount" {
  description = "Number of nodes in the AKS cluster"
  type = number
  default = 2
}
variable "VM_size" {
    description = "Size of the virtual machines Node"
    type = string
    default = "Standard_D2alds_v6"
}
variable "acrname" {
  description = "azure container registry name"
    type = string
}
variable "acrrgname" {
  description = "azure container registry resource group name"
    type = string
}