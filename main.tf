terraform {
  # backend "azurerm" {
  # }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.94.0"
    }
    databricks = {
      # source  = "databrickslabs/databricks"
      source  = "databricks/databricks"
      version = "=0.5.9"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "databricks" {
  azure_workspace_resource_id = module.adb.adb_id
}

module "rg" {
  source         = "./modules/resource-group"
  owner          = var.owner
  purpose        = var.purpose
  location       = var.location
  org            = var.org
  owner_custom   = var.owner_custom
  purpose_custom = var.purpose_custom
}

module "network" {
  source         = "./modules/network"
  owner_custom   = var.owner_custom
  purpose_custom = var.purpose_custom
  address_space  = var.address_space
  location       = var.location
  subnets        = var.subnets
  nsg            = var.nsg
  depends_on     = [module.rg]
}

module "adb" {
  source                                               = "./modules/adb"
  owner_custom                                         = var.owner_custom
  purpose_custom                                       = var.purpose_custom
  location                                             = var.location
  vnet_id                                              = module.network.vnet_id
  public_subnet_network_security_group_association_id  = module.network.public_nsg_association
  private_subnet_network_security_group_association_id = module.network.private_nsg_association
  key_vault_id                                         = module.keyvault.kv_id
  key_vault_uri                                        = module.keyvault.kv_uri
  depends_on                                           = [module.network]

}

module "keyvault" {
  source              = "./modules/keyvault"
  owner_custom        = var.owner_custom
  purpose_custom      = var.purpose_custom
  current_user       = var.current_user
  location            = var.location
  private_link_subnet = module.network.private_link_subnet
  vnet_id             = module.network.vnet_id
}


module "db" {
  source              = "./modules/db"
  owner_custom        = var.owner_custom
  purpose_custom      = var.purpose_custom
  location            = var.location
  private_link_subnet = module.network.private_link_subnet
  key_vault_id        = module.keyvault.kv_id
  vnet_id             = module.network.vnet_id
}

module "firewall" {
  source = "./modules/firewall"
  owner_custom        = var.owner_custom
  purpose_custom      = var.purpose_custom
  location            = var.location 
  fw_subnet_id = module.network.firewall_subnet
  rt_public_subnet = module.network.public_subnet_id
  rt_private_subnet = module.network.private_subnet_id
}