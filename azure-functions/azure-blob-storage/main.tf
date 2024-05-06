resource "azurerm_resource_group" "example" {
  name     = var.example
  location = var.West_Europe
}


resource "azurerm_storage_account" "example" {
  name                     = var.storageaccountname
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = var.Standard
  account_replication_type = var.GRS

  tags = {
    environment = "staging"
  }
}


resource "azurerm_storage_container" "example" {
  name                  = var.example_vhds
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = var.private
}




resource "azurerm_storage_blob" "example" {
  name                   = var.my_awesome
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = var.Block
  source                 = var.local_file
}