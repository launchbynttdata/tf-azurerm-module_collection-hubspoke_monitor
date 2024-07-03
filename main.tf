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

module "resource_names" {
  source  = "terraform.registry.launch.nttdata.com/module_library/resource_name/launch"
  version = "~> 1.0"

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

module "resource_group" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm"
  version = "~> 1.0"

  name     = local.resource_group_name
  location = var.location
  tags = {
    resource_name = local.resource_group_name
  }
}

// Create diagnostic settings for the firewall
module "monitor_diagnostic_setting" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/monitor_diagnostic_setting/azurerm"
  version = "~> 1.0"

  name                           = local.monitor_diagnostic_setting_name
  target_resource_id             = var.firewall_id
  log_analytics_workspace_id     = module.log_analytics_workspace.id
  log_analytics_destination_type = var.log_analytics_destination_type
  enabled_log                    = var.enabled_log
  metric                         = var.metric
}

// Create a Log Analytics Workspace to be attached to diagnostic settings
module "log_analytics_workspace" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/log_analytics_workspace/azurerm"
  version = "~> 1.0"

  name                = local.log_analytics_workspace_name
  location            = var.location
  resource_group_name = module.resource_group.name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
  identity            = var.identity

  depends_on = [module.resource_group]
}

// Create a Storage Account for Network Watcher Flow Logs
module "storage_account" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/storage_account/azurerm"
  version = "~> 1.0"

  storage_account_name = local.storage_account_name
  resource_group_name  = module.resource_group.name
  location             = var.location

  account_tier              = var.account_tier
  account_kind              = var.account_kind
  account_replication_type  = var.account_replication_type
  enable_https_traffic_only = var.enable_https_traffic_only

  depends_on = [module.resource_group]
}


// Create a Network Watcher
module "network_watcher" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/network_watcher/azurerm"
  version = "~> 1.0"

  count                = var.create_network_watcher ? 1 : 0
  network_watcher_name = local.network_watcher_name
  location             = var.location
  resource_group_name  = local.network_watcher_resource_group

  depends_on = [module.resource_group]
}

// Create a Network Watcher Flow Log for the Network Security Group
module "network_watcher_flow_log" {
  source  = "terraform.registry.launch.nttdata.com/module_primitive/network_watcher_flow_log/azurerm"
  version = "~> 1.0"

  network_watcher_flow_log_name = local.network_watcher_flow_log_name
  network_watcher_name          = local.network_watcher_name
  resource_group_name           = local.network_watcher_resource_group

  network_security_group_id = var.network_security_group_id
  storage_account_id        = module.storage_account.id
  enabled                   = var.network_watcher_flow_log_enabled

  retention_policy  = var.retention_policy
  traffic_analytics = local.traffic_analytics

  depends_on = [module.resource_group, module.network_watcher, module.storage_account]
}
