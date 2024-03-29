resource "azurerm_resource_group" "sec_rg" {
  name     = format("%s-sec-rg", local.project)
  location = var.location

  tags = var.tags
}

module "key_vault" {
  source              = "git::https://github.com/pagopa/azurerm.git//key_vault?ref=v1.0.48"
  name                = format("%s-kv", local.project)
  location            = azurerm_resource_group.sec_rg.location
  resource_group_name = azurerm_resource_group.sec_rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  lock_enable         = var.lock_enable

  tags = var.tags
}

# Azure AD
data "azuread_group" "adgroup_admin" {
  display_name = format("%s-adgroup-admin", local.project)
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "ad_group_policy" {
  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_admin.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", ]
}

data "azuread_group" "adgroup_developers" {
  display_name = format("%s-adgroup-developers", local.project)
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_developers_policy" {
  count = var.env_short == "d" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_developers.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", ]
}

data "azuread_group" "adgroup_externals" {
  display_name = format("%s-adgroup-externals", local.project)
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_externals_policy" {
  count = var.env_short == "d" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_externals.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", ]
}

data "azuread_group" "adgroup_security" {
  display_name = format("%s-adgroup-security", local.project)
}

## ad group policy ##
resource "azurerm_key_vault_access_policy" "adgroup_security_policy" {
  count = var.env_short == "d" ? 1 : 0

  key_vault_id = module.key_vault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_group.adgroup_security.object_id

  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", ]
  secret_permissions      = ["Get", "List", "Set", "Delete", ]
  storage_permissions     = []
  certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Restore", "Purge", "Recover", ]
}

## azure devops ##
data "azuread_service_principal" "azdo_sp_tls_cert" {
  count        = var.azdo_sp_tls_cert_enabled ? 1 : 0
  display_name = format("azdo-sp-%s-tls-cert", local.project)
}

resource "azurerm_key_vault_access_policy" "azdo_sp_tls_cert" {
  count        = var.azdo_sp_tls_cert_enabled ? 1 : 0
  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.azdo_sp_tls_cert[0].object_id

  certificate_permissions = ["Get", "Import", ]
}

data "azurerm_key_vault_secret" "sec_workspace_id" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "sec-workspace-id"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "sec_storage_id" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "sec-storage-id"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "postgres-connection-url" {
  name         = format("%s-%s", "postgres-connection-url", var.environment)
  key_vault_id = module.key_vault.id.id
}

data "azurerm_key_vault_secret" "postgres-server-admin" {
  name         = format("%s-%s", "postgres-server-admin", var.environment)
  key_vault_id = module.key_vault.id.id
}

data "azurerm_key_vault_secret" "postgres-server-password" {
  name         = format("%s-%s", "postgres-server-password", var.environment)
  key_vault_id = module.key_vault.id.id
}

data "azurerm_key_vault_secret" "address-space" {
  name         = format("%s-%s", "address-space", var.environment)
  key_vault_id = module.key_vault.id.id
}

data "azurerm_key_vault_secret" "subnet-address-space" {
  name         = format("%s-%s", "subnet-address-space", var.environment)
  key_vault_id = module.key_vault.id.id
}

data "azurerm_key_vault_secret" "endpointsubnet-address-space" {
  name         = format("%s-%s", "endpointsubnet-address-space", var.environment)
  key_vault_id = module.key_vault.id.id
}

data "azurerm_key_vault_secret" "ip-restrictions-pda" {
  name         = format("%s-%s", "ip-restrictions-pda", var.environment)
  key_vault_id = module.key_vault.id.id
}

data "azurerm_key_vault_secret" "backend-address-pool-ip" {
  name         = format("%s-%s", "backend-address-pool-ip", var.environment)
  key_vault_id = module.key_vault.id.id
}

data "azurerm_key_vault_secret" "appgw-subnet-address-space" {
  name         = format("%s-%s", "appgw-subnet-address-space", var.environment)
  key_vault_id = module.key_vault.id.id
}

data "azurerm_key_vault_secret" "appgw-private-ip-address" {
  name         = format("%s-%s", "appgw-private-ip-address", var.environment)
  key_vault_id = module.key_vault.id.id
}

data "azurerm_key_vault_secret" "apim-public-ip" {
  name         = format("%s-%s", "apim-public-ip", var.environment)
  key_vault_id = module.key_vault.id.id
}

data "azurerm_key_vault_secret" "java-options" {
  name         = "java-options"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}