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
locals {
  resource_group_name             = module.resource_names["resource_group"].standard
  log_analytics_workspace_name    = module.resource_names["log_analytics_workspace"].standard
  monitor_diagnostic_setting_name = module.resource_names["monitor_diagnostic_setting"].standard
  network_watcher_name            = var.create_network_watcher ? module.resource_names["network_watcher"].standard : "NetworkWatcher_${var.location}"
  network_watcher_resource_group  = var.create_network_watcher ? module.resource_group.name : "NetworkWatcherRG"
  storage_account_name            = module.resource_names["storage_account"].minimal_random_suffix_without_any_separators
  network_watcher_flow_log_name   = module.resource_names["network_watcher_flow_log"].standard

  traffic_analytics = merge(
    var.traffic_analytics,
    {
      workspace_id          = module.log_analytics_workspace.workspace_id
      workspace_region      = var.location
      workspace_resource_id = module.log_analytics_workspace.id
  })

}
