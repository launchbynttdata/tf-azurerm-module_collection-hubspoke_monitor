// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module "monitor" {
  source = "../.."

  resource_names_map      = var.resource_names_map
  instance_env            = var.instance_env
  instance_resource       = var.instance_resource
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
  class_env               = var.class_env
  location                = var.location

  firewall_id = local.firewall_id

  sku                            = var.log_analytics_workspace_sku
  retention_in_days              = var.retention_in_days
  identity                       = var.identity
  log_analytics_destination_type = var.log_analytics_destination_type
  enabled_log                    = var.enabled_log
  metric                         = var.metric

  network_security_group_id = module.network_security_group.network_security_group_id

  account_tier              = var.account_tier
  account_kind              = var.account_kind
  account_replication_type  = var.account_replication_type
  enable_https_traffic_only = var.enable_https_traffic_only

  create_network_watcher = var.create_network_watcher

  network_watcher_flow_log_enabled = var.network_watcher_flow_log_enabled
  retention_policy                 = var.retention_policy
  traffic_analytics                = var.traffic_analytics

}

module "resource_names" {
  source = "git::https://github.com/launchbynttdata/tf-launch-module_library-resource_name.git?ref=1.0.0"

  for_each = var.resource_names_map

  region                  = join("", split("-", var.location))
  class_env               = var.class_env
  cloud_resource_type     = each.value.name
  instance_env            = var.instance_env
  instance_resource       = var.instance_resource
  maximum_length          = each.value.max_length
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
}


module "hub_vnet" {
  source = "git::https://github.com/launchbynttdata/tf-azurerm-module_collection-hub_network.git?ref=1.0.0"


  resource_names_map      = var.resource_names_map
  instance_env            = var.instance_env
  class_env               = var.class_env
  logical_product_family  = var.logical_product_family
  logical_product_service = var.logical_product_service
  instance_resource       = var.instance_resource
  location                = var.location

  network                                        = var.network
  firewall                                       = var.firewall
  firewall_policy_rule_collection_group_priority = var.firewall_policy_rule_collection_group_priority
  application_rule_collection                    = var.application_rule_collection
  network_rule_collection                        = var.network_rule_collection
  nat_rule_collection                            = var.nat_rule_collection
}

module "network_security_group" {
  source = "git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-network_security_group.git?ref=1.0.0"

  name                = local.network_security_group_name
  location            = var.location
  resource_group_name = module.monitor.resource_group_name
}

module "nsg_subnet_association" {
  source = "git::https://github.com/launchbynttdata/tf-azurerm-module_primitive-nsg_subnet_association.git?ref=1.0.0"

  network_security_group_id = local.network_security_group_id
  subnet_id                 = local.subnet_id

  depends_on = [module.network_security_group, module.hub_vnet]
}
