# general
env_short = "d"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "product"
  Source      = "https://github.com/pagopa/product-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = false

# networking
cidr_vnet         = ["10.1.0.0/16"]
cidr_subnet_azdoa = ["10.1.130.0/24"]

# dns
external_domain = "pagopa.it"
dns_zone_prefix = "dev.product"

# azure devops
azdo_sp_tls_cert_enabled = false
enable_azdoa             = false
enable_iac_pipeline      = false

## App service definition plan
#########################################################
name = "pda-appsrv"
environment = "dev"
location = "West Europe"
plan_sku = "P1v3"
plan_sku_tier = "PremiumV3"
plan_kind = "Linux"
plan_reserved = "true"
app_command_line = "/home/site/deployments/tools/startup_script.sh"

## App service configuration
#########################################################
spring_config_location = "file:///home/site/appconfig/application-ti.yml"

## JAVA OPTS
#########################################################
java_opts = "-Dfile.encoding=UTF-8 -Ddandelion.profile.active=prod"

## SYSTEM ENCODING
#########################################################
system_encoding = "C.UTF-8"

## WEBSITE HTTP LOGGING RETENTION DAYS
#########################################################
http_log_retention_days = 365

## APP Service runtime config
#########################################################
runtime_name = "jbosseap"
runtime_version = "7-java8"

## Network configuration variables
#########################################################
# Network resource
network_resource = "DDS-NetworkResources"

# VNET reference
vnet_name = "DDS_DEV_APPSERVICES_VNET"

# Integration subnet
subnet_name = "pda_dev_subnet"

# Private endpoint connection
endpointsubnet_name = "pda-dev-endpt-subnet"

# Private link dns zone
private_link_dns_zone = "privatelink.azurewebsites.net"

## Application Gateway variables
#########################################################
## APPGTW Resource group
appgw_rg = "DDS-ApplicationGateway"
appgw_name = "pda-appgw"
backend_address_pool_name = "pda-jboss"
backend_http_settings_host_name = "ddsappservices-pda.azurewebsites.net"
appgw_subnet_name = "pda_app_gtw_dev"
appgw_sku_size = "WAF_v2"

## Key vault variables
#########################################################
## Key vault name
key_vault = "KMN-PDA-Pagopa-Test"

## Key vault resource group
key_vault_rg = "KMN-VaultResources"