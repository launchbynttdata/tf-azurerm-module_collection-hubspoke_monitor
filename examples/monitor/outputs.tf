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

output "resource_group_id" {
  description = "resource group id"
  value       = module.monitor.resource_group_id
}

output "resource_group_name" {
  description = "resource group name"
  value       = module.monitor.resource_group_name
}

output "diagnostic_setting_id" {
  description = "The ID of the Diagnostic Setting."
  value       = module.monitor.diagnostic_setting_id
}

output "diagnostic_setting_name" {
  description = "The name of the Diagnostic Setting."
  value       = module.monitor.diagnostic_setting_name
}


output "log_analytics_workspace_id" {
  description = "The Log Analytics Workspace ID."
  value       = module.monitor.log_analytics_workspace_id
}

output "log_analytics_workspace_workspace_id" {
  description = "The Workspace (or Customer) ID for the Log Analytics Workspace."
  value       = module.monitor.log_analytics_workspace_workspace_id
}

output "log_analytics_workspace_name" {
  description = "The Log Analytics Workspace name."
  value       = module.monitor.log_analytics_workspace_name
}

output "log_analytics_workspace_primary_shared_key" {
  description = "Value of the primary shared key for the Log Analytics Workspace."
  value       = module.monitor.log_analytics_workspace_primary_shared_key
  sensitive   = true
}

output "log_analytics_workspace_secondary_shared_key" {
  description = "Value of the secondary shared key for the Log Analytics Workspace."
  value       = module.monitor.log_analytics_workspace_secondary_shared_key
  sensitive   = true
}

output "storage_account_id" {
  description = "The ID of the Storage Account."
  value       = module.monitor.storage_account_id
}

output "storage_account_primary_location" {
  description = "The primary location of the storage account."
  value       = module.monitor.storage_account_primary_location
}

output "storage_account_primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location."
  value       = module.monitor.storage_account_primary_blob_endpoint
}

output "storage_account_storage_containers" {
  description = "storage container resource map"
  value       = module.monitor.storage_account_storage_containers
}

output "storage_account_storage_queues" {
  description = "storage queues resource map"
  value       = module.monitor.storage_account_storage_queues
}

output "storage_account_storage_shares" {
  description = "storage share resource map"
  value       = module.monitor.storage_account_storage_shares
}

output "network_watcher_flow_log_id" {
  description = "The ID of the Network Watcher Flow Log instance."
  value       = module.monitor.network_watcher_flow_log_id
}

output "network_watcher_flow_log_name" {
  description = "The name of the Network Watcher Flow Log."
  value       = module.monitor.network_watcher_flow_log_name
}
