# Resource Group

resource "azurerm_resource_group" "example" {
  name     = var.resource_name
  location = var.example_location
}



resource "azurerm_storage_account" "example" {
  name                     = var.storage_account
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = var.storage_account1
  account_replication_type = var.storage_account2

  tags = {
    environment = "staging"
  }
}



resource "azurerm_service_plan" "example" {
  name                = var.example_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  os_type             = var.example_Linux
  sku_name            = var.example_P1v2
}



resource "azurerm_linux_function_app" "example" {
  name                = var.example_linux_fun
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  service_plan_id            = azurerm_service_plan.example.id

  site_config {}
}


resource "azurerm_function_app_function" "example" {
  name            = var.example-function-app-function
  function_app_id = azurerm_linux_function_app.example.id
  language        = var.Python
  test_data = jsonencode({
    "name" = var.azure
  })
  config_json = jsonencode({
    "bindings" = [
      {
        "authLevel" = var.function_auth
        "direction" = var.in_direction
        "methods" = [
          "get",
          "post",
        ]
        "name" = var.req_example
        "type" = var.httpTrigger
      },
      {
        "direction" = var.out
        "name"      = var.return_examp
        "type"      = var.http_example
      },
    ]
  })
}
