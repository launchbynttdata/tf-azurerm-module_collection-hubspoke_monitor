# tf-azurerm-module_collection-hubspoke_monitor

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | <= 1.5.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.77 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_monitor"></a> [monitor](#module\_monitor) | ../.. | n/a |
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 1.0 |
| <a name="module_hub_vnet"></a> [hub\_vnet](#module\_hub\_vnet) | terraform.registry.launch.nttdata.com/module_collection/hub_network/azurerm | ~> 1.0 |
| <a name="module_network_security_group"></a> [network\_security\_group](#module\_network\_security\_group) | terraform.registry.launch.nttdata.com/module_primitive/network_security_group/azurerm | ~> 1.0 |
| <a name="module_nsg_subnet_association"></a> [nsg\_subnet\_association](#module\_nsg\_subnet\_association) | terraform.registry.launch.nttdata.com/module_primitive/nsg_subnet_association/azurerm | ~> 1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>    region     = optional(string, "eastus2")<br>  }))</pre> | `{}` | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"network"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"dev"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region to use | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_sku"></a> [log\_analytics\_workspace\_sku](#input\_log\_analytics\_workspace\_sku) | (Optional) Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018. | `string` | `"Free"` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | (Optional) The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730. | `number` | `"30"` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) A identity block as defined below. | <pre>object({<br>    type = string<br>  })</pre> | `null` | no |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | (Optional) Specifies the type of destination for the logs. Possible values are 'Dedicated' or 'Workspace'. | `string` | `null` | no |
| <a name="input_enabled_log"></a> [enabled\_log](#input\_enabled\_log) | n/a | <pre>list(object({<br>    category_group = optional(string, "allLogs")<br>    category       = optional(string, null)<br>  }))</pre> | `null` | no |
| <a name="input_metric"></a> [metric](#input\_metric) | n/a | <pre>object({<br>    category = optional(string)<br>    enabled  = optional(bool)<br>  })</pre> | `null` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Defines the Tier to use for this storage account. Valid options are Standard and Premium. | `string` | `"Standard"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Defines the Kind to use for this storage account. Valid options are Storage, StorageV2, BlobStorage, FileStorage, BlockBlobStorage. | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS. | `string` | `"LRS"` | no |
| <a name="input_enable_https_traffic_only"></a> [enable\_https\_traffic\_only](#input\_enable\_https\_traffic\_only) | Allows https traffic only to storage service if set to true. | `bool` | `true` | no |
| <a name="input_create_network_watcher"></a> [create\_network\_watcher](#input\_create\_network\_watcher) | Create network watcher | `bool` | `false` | no |
| <a name="input_network_watcher_flow_log_enabled"></a> [network\_watcher\_flow\_log\_enabled](#input\_network\_watcher\_flow\_log\_enabled) | Enable network watcher flow log | `bool` | `true` | no |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | The retention policy for the Network Watcher Flow Log | <pre>object({<br>    enabled = bool<br>    days    = number<br>  })</pre> | `null` | no |
| <a name="input_traffic_analytics"></a> [traffic\_analytics](#input\_traffic\_analytics) | The traffic analytics settings for the Network Watcher Flow Log | <pre>object({<br>    enabled             = bool<br>    interval_in_minutes = number<br>  })</pre> | `null` | no |
| <a name="input_network"></a> [network](#input\_network) | Attributes of virtual network to be created. | <pre>object({<br>    use_for_each    = bool<br>    address_space   = optional(list(string), ["10.0.0.0/16"])<br>    subnet_names    = optional(list(string), [])<br>    subnet_prefixes = optional(list(string), [])<br>    bgp_community   = optional(string, null)<br>    ddos_protection_plan = optional(object(<br>      {<br>        enable = bool<br>        id     = string<br>      }<br>    ), null)<br>    dns_servers                                           = optional(list(string), [])<br>    nsg_ids                                               = optional(map(string), {})<br>    route_tables_ids                                      = optional(map(string), {})<br>    subnet_delegation                                     = optional(map(map(any)), {})<br>    subnet_enforce_private_link_endpoint_network_policies = optional(map(bool), {})<br>    subnet_enforce_private_link_service_network_policies  = optional(map(bool), {})<br>    subnet_service_endpoints                              = optional(map(list(string)), {})<br>    tags                                                  = optional(map(string), {})<br>    tracing_tags_enabled                                  = optional(bool, false)<br>    tracing_tags_prefix                                   = optional(string, "")<br>  })</pre> | n/a | yes |
| <a name="input_firewall"></a> [firewall](#input\_firewall) | Attributes to create a azure firewall | <pre>object({<br>    logs_destinations_ids = list(string)<br>    subnet_cidr           = optional(string)<br>    additional_public_ips = optional(list(object(<br>      {<br>        name                 = string,<br>        public_ip_address_id = string<br>    })), [])<br>    application_rule_collections = optional(list(object(<br>      {<br>        name     = string,<br>        priority = number,<br>        action   = string,<br>        rules = list(object(<br>          { name             = string,<br>            source_addresses = list(string),<br>            source_ip_groups = list(string),<br>            target_fqdns     = list(string),<br>            protocols = list(object(<br>              { port = string,<br>            type = string }))<br>          }<br>        ))<br>    })))<br>    custom_diagnostic_settings_name = optional(string)<br>    custom_firewall_name            = optional(string)<br>    dns_servers                     = optional(string)<br>    extra_tags                      = optional(map(string))<br>    firewall_private_ip_ranges      = optional(list(string))<br>    ip_configuration_name           = string<br>    network_rule_collections = optional(list(object({<br>      name     = string,<br>      priority = number,<br>      action   = string,<br>      rules = list(object({<br>        name                  = string,<br>        source_addresses      = list(string),<br>        source_ip_groups      = optional(list(string)),<br>        destination_ports     = list(string),<br>        destination_addresses = list(string),<br>        destination_ip_groups = optional(list(string)),<br>        destination_fqdns     = optional(list(string)),<br>        protocols             = list(string)<br>      }))<br>    })))<br>    public_ip_zones = optional(list(number))<br>    sku_tier        = string<br>    zones           = optional(list(number))<br>  })</pre> | `null` | no |
| <a name="input_firewall_policy_rule_collection_group_priority"></a> [firewall\_policy\_rule\_collection\_group\_priority](#input\_firewall\_policy\_rule\_collection\_group\_priority) | (Required) The priority of the Firewall Policy Rule Collection Group. The range is 100-65000. | `number` | n/a | yes |
| <a name="input_application_rule_collection"></a> [application\_rule\_collection](#input\_application\_rule\_collection) | (Optional) The Application Rule Collection to use in this Firewall Policy Rule Collection Group. | <pre>list(object({<br>    name     = string<br>    action   = string<br>    priority = number<br>    rule = list(object({<br>      name        = string<br>      description = optional(string)<br>      protocols = optional(list(object({<br>        type = string<br>        port = number<br>      })))<br>      http_headers = optional(list(object({<br>        name  = string<br>        value = string<br>      })))<br>      source_addresses      = optional(list(string))<br>      source_ip_groups      = optional(list(string))<br>      destination_addresses = optional(list(string))<br>      destination_urls      = optional(list(string))<br>      destination_fqdns     = optional(list(string))<br>      destination_fqdn_tags = optional(list(string))<br>      terminate_tls         = optional(bool)<br>      web_categories        = optional(list(string))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_network_rule_collection"></a> [network\_rule\_collection](#input\_network\_rule\_collection) | (Optional) The Network Rule Collection to use in this Firewall Policy Rule Collection Group. | <pre>list(object({<br>    name     = string<br>    action   = string<br>    priority = number<br>    rule = list(object({<br>      name                  = string<br>      description           = optional(string)<br>      protocols             = list(string)<br>      destination_ports     = list(string)<br>      source_addresses      = optional(list(string))<br>      source_ip_groups      = optional(list(string))<br>      destination_addresses = optional(list(string))<br>      destination_fqdns     = optional(list(string))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_nat_rule_collection"></a> [nat\_rule\_collection](#input\_nat\_rule\_collection) | (Optional) The NAT Rule Collection to use in this Firewall Policy Rule Collection Group. | <pre>list(object({<br>    name     = string<br>    action   = string<br>    priority = number<br>    rule = list(object({<br>      name               = string<br>      description        = optional(string)<br>      protocols          = list(string)<br>      source_addresses   = optional(list(string))<br>      source_ip_groups   = optional(list(string))<br>      destination_ports  = optional(list(string))<br>      translated_address = optional(string)<br>      translated_port    = number<br>      translated_fqdn    = optional(string)<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | resource group id |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | resource group name |
| <a name="output_diagnostic_setting_id"></a> [diagnostic\_setting\_id](#output\_diagnostic\_setting\_id) | The ID of the Diagnostic Setting. |
| <a name="output_diagnostic_setting_name"></a> [diagnostic\_setting\_name](#output\_diagnostic\_setting\_name) | The name of the Diagnostic Setting. |
| <a name="output_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#output\_log\_analytics\_workspace\_id) | The Log Analytics Workspace ID. |
| <a name="output_log_analytics_workspace_workspace_id"></a> [log\_analytics\_workspace\_workspace\_id](#output\_log\_analytics\_workspace\_workspace\_id) | The Workspace (or Customer) ID for the Log Analytics Workspace. |
| <a name="output_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#output\_log\_analytics\_workspace\_name) | The Log Analytics Workspace name. |
| <a name="output_log_analytics_workspace_primary_shared_key"></a> [log\_analytics\_workspace\_primary\_shared\_key](#output\_log\_analytics\_workspace\_primary\_shared\_key) | Value of the primary shared key for the Log Analytics Workspace. |
| <a name="output_log_analytics_workspace_secondary_shared_key"></a> [log\_analytics\_workspace\_secondary\_shared\_key](#output\_log\_analytics\_workspace\_secondary\_shared\_key) | Value of the secondary shared key for the Log Analytics Workspace. |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the Storage Account. |
| <a name="output_storage_account_primary_location"></a> [storage\_account\_primary\_location](#output\_storage\_account\_primary\_location) | The primary location of the storage account. |
| <a name="output_storage_account_primary_blob_endpoint"></a> [storage\_account\_primary\_blob\_endpoint](#output\_storage\_account\_primary\_blob\_endpoint) | The endpoint URL for blob storage in the primary location. |
| <a name="output_storage_account_storage_containers"></a> [storage\_account\_storage\_containers](#output\_storage\_account\_storage\_containers) | storage container resource map |
| <a name="output_storage_account_storage_queues"></a> [storage\_account\_storage\_queues](#output\_storage\_account\_storage\_queues) | storage queues resource map |
| <a name="output_storage_account_storage_shares"></a> [storage\_account\_storage\_shares](#output\_storage\_account\_storage\_shares) | storage share resource map |
| <a name="output_network_watcher_flow_log_id"></a> [network\_watcher\_flow\_log\_id](#output\_network\_watcher\_flow\_log\_id) | The ID of the Network Watcher Flow Log instance. |
| <a name="output_network_watcher_flow_log_name"></a> [network\_watcher\_flow\_log\_name](#output\_network\_watcher\_flow\_log\_name) | The name of the Network Watcher Flow Log. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
