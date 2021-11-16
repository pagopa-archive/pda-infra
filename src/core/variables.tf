# general

variable "prefix" {
  type    = string
  default = "product"
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) <= 1
    )
    error_message = "Max length is 1 chars."
  }
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "lock_enable" {
  type        = bool
  default     = false
  description = "Apply locks to block accedentaly deletions."
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
}

# network
variable "cidr_vnet" {
  type        = list(string)
  description = "Virtual network address space."
}

# dns
variable "dns_default_ttl_sec" {
  type        = number
  description = "value"
  default     = 3600
}

variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

variable "dns_zone_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

# azure devops
variable "azdo_sp_tls_cert_enabled" {
  type        = string
  description = "Enable Azure DevOps connection for TLS cert management"
  default     = false
}

variable "enable_azdoa" {
  type        = bool
  description = "Enable Azure DevOps agent."
}

variable "cidr_subnet_azdoa" {
  type        = list(string)
  description = "Azure DevOps agent network address space."
}

variable "enable_iac_pipeline" {
  type        = bool
  description = "If true create the key vault policy to allow used by azure devops iac pipelines."
  default     = false
}
variable "rg" {
  type        = string
  description = "Resource group variable."
}

variable "name" {
  type        = string
  description = "Location of the azure resource group."
}

variable "environment" {
  type        = string
  description = "Name of the deployment environment"
}

variable "plan_sku" {
  type        = string
  description = "The sku of app service plan to create"
}

variable "plan_sku_tier" {
  type        = string
  description = "The sku tier of app service plan to create"
}

variable "plan_kind" {
  type        = string
  description = "The sku kind of app service plan to create. (ES. Linux, Windows)"
}

variable "plan_reserved" {
  type        = string
  description = "(Optional) Is this App Service Plan Reserved. Defaults to false."
  default     = "true"
}

## App service configuration
#########################################################
## Location of SPRING configuration file
variable "spring_config_location" {
  type        = string
  description = "Spring config location"
}

## SYSTEM ENCODING
#########################################################
## SET C.UTF-8
variable "system_encoding" {
  type        = string
  description = "Set LANG encoding UTF-8"
  default = "C.UTF-8"
}

## WEBSITE HTTP LOGGING RETENTION DAYS
#########################################################
variable "http_log_retention_days" {
  type        = string
}

## APP Service runtime config
#########################################################
## Name
variable "runtime_name" {
  type        = string
}
## Version
variable "runtime_version" {
  type        = string
}
## App Command Line
variable "app_command_line" {
  type        = string
  default     = ""
  description = "Provide an optional startup command that will be run as part of container startup."
}

## Network configuration variables
#########################################################
## VNET name
variable "vnet_name" {
    type = string
}

## Subnet name
variable "subnet_name" {
    type = string
}

## Private endpoint subnet name
variable "endpointsubnet_name" {
    type = string
}

variable "private_link_dns_zone" {
  type = string
}
## Application Gateway variables
#########################################################
## APPGTW Resource group
variable "appgw_rg" {
  type = string
  description = "Application gateway reource group"
}
## APPGTW name
variable "appgw_name" {
  type = string
  description = "Application gateway name"
}

##  Backend address pool NAME
variable "backend_address_pool_name" {
  type = string
}
## backend HTTP settings host name
variable "backend_http_settings_host_name" {
  type = string
}
######## NETWORK 

## Subnet name
variable "appgw_subnet_name" {
    type = string
}

## Sku size
variable "appgw_sku_size" {
  type = string
}

## Key Vault
#########################################################
variable "key_vault" {
  type = string
  description = "Key Vault name"
}

variable "key_vault_rg" {
  type = string
  description = "Key Vault resource group"
}