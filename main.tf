resource "random_id" "this" {
  count = var.randomize_name ? 1 : 0
  keepers = {
    name = var.name
  }
  byte_length = 12
}

resource "azurerm_container_registry" "this" {
  name                = var.randomize_name ? substr("${var.name}${random_id.this[0].dec}", 0, 50) : var.name
  resource_group_name = var.rg.name
  location            = var.rg.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags["business_unit"],
      tags["environment"],
      tags["environment_finops"],
      tags["product"],
      tags["subscription_type"]
    ]
  }
}

resource "azurerm_role_assignment" "this" {
  for_each                         = var.role_assignments
  scope                            = azurerm_container_registry.this.id
  principal_id                     = each.value.principal_id
  role_definition_name             = each.value.role_definition_name
  skip_service_principal_aad_check = each.value.skip_service_principal_aad_check
}