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

// resource name module
variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-module-resource_name to generate resource names"
  type = map(object({
    name       = string
    max_length = optional(number, 60)
    region     = optional(string, "eastus2")
  }))

  default = {}
}

variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = 0

  validation {
    condition     = var.instance_env >= 0 && var.instance_env <= 999
    error_message = "Instance number should be between 0 to 999."
  }
}

variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = 0

  validation {
    condition     = var.instance_resource >= 0 && var.instance_resource <= 100
    error_message = "Instance number should be between 0 to 100."
  }
}

variable "logical_product_family" {
  type        = string
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_family))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "launch"
}

variable "logical_product_service" {
  type        = string
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_service))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "network"
}

variable "class_env" {
  type        = string
  description = "(Required) Environment where resource is going to be deployed. For example. dev, qa, uat"
  nullable    = false
  default     = "dev"

  validation {
    condition     = length(regexall("\\b \\b", var.class_env)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "location" {
  description = "Azure region to use"
  type        = string

  validation {
    condition     = length(regexall("\\b \\b", var.location)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

// Log Analytics Workspace
variable "log_analytics_workspace_sku" {
  type        = string
  description = "(Optional) Specifies the SKU of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation, and PerGB2018 (new SKU as of 2018-04-03). Defaults to PerGB2018."
  default     = "Free"
}

variable "retention_in_days" {
  type        = number
  description = "(Optional) The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730."
  default     = "30"
}

variable "identity" {
  type = object({
    type = string
  })
  description = "(Optional) A identity block as defined below."
  default     = null
}

// diagnostic setting
variable "log_analytics_destination_type" {
  type        = string
  description = "(Optional) Specifies the type of destination for the logs. Possible values are 'Dedicated' or 'Workspace'."
  default     = null
}

variable "enabled_log" {
  type = list(object({
    category_group = optional(string, "allLogs")
    category       = optional(string, null)
  }))
  default = null
}

variable "metric" {
  type = object({
    category = optional(string)
    enabled  = optional(bool)
  })
  default = null
}

//storage account
variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium."
  default     = "Standard"
}

variable "account_kind" {
  type        = string
  description = "Defines the Kind to use for this storage account. Valid options are Storage, StorageV2, BlobStorage, FileStorage, BlockBlobStorage."
  default     = "StorageV2"
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  default     = "LRS"
}

variable "enable_https_traffic_only" {
  type        = bool
  description = "Allows https traffic only to storage service if set to true."
  default     = true
}

// network watcher
variable "create_network_watcher" {
  type        = bool
  description = "Create network watcher"
  default     = false
}

//network watcher flow log
variable "network_watcher_flow_log_enabled" {
  type        = bool
  description = "Enable network watcher flow log"
  default     = true
}

variable "retention_policy" {
  description = "The retention policy for the Network Watcher Flow Log"
  type = object({
    enabled = bool
    days    = number
  })
  default = null
}

variable "traffic_analytics" {
  description = "The traffic analytics settings for the Network Watcher Flow Log"
  type = object({
    enabled             = bool
    interval_in_minutes = number
  })
  default = null
}

//networking module
variable "network" {
  description = "Attributes of virtual network to be created."
  type = object({
    use_for_each    = bool
    address_space   = optional(list(string), ["10.0.0.0/16"])
    subnet_names    = optional(list(string), [])
    subnet_prefixes = optional(list(string), [])
    bgp_community   = optional(string, null)
    ddos_protection_plan = optional(object(
      {
        enable = bool
        id     = string
      }
    ), null)
    dns_servers                                           = optional(list(string), [])
    nsg_ids                                               = optional(map(string), {})
    route_tables_ids                                      = optional(map(string), {})
    subnet_delegation                                     = optional(map(map(any)), {})
    subnet_enforce_private_link_endpoint_network_policies = optional(map(bool), {})
    subnet_enforce_private_link_service_network_policies  = optional(map(bool), {})
    subnet_service_endpoints                              = optional(map(list(string)), {})
    tags                                                  = optional(map(string), {})
    tracing_tags_enabled                                  = optional(bool, false)
    tracing_tags_prefix                                   = optional(string, "")
  })
}

variable "firewall" {
  description = "Attributes to create a azure firewall"
  type = object({
    logs_destinations_ids = list(string)
    subnet_cidr           = optional(string)
    additional_public_ips = optional(list(object(
      {
        name                 = string,
        public_ip_address_id = string
    })), [])
    application_rule_collections = optional(list(object(
      {
        name     = string,
        priority = number,
        action   = string,
        rules = list(object(
          { name             = string,
            source_addresses = list(string),
            source_ip_groups = list(string),
            target_fqdns     = list(string),
            protocols = list(object(
              { port = string,
            type = string }))
          }
        ))
    })))
    custom_diagnostic_settings_name = optional(string)
    custom_firewall_name            = optional(string)
    dns_servers                     = optional(string)
    extra_tags                      = optional(map(string))
    firewall_private_ip_ranges      = optional(list(string))
    ip_configuration_name           = string
    network_rule_collections = optional(list(object({
      name     = string,
      priority = number,
      action   = string,
      rules = list(object({
        name                  = string,
        source_addresses      = list(string),
        source_ip_groups      = optional(list(string)),
        destination_ports     = list(string),
        destination_addresses = list(string),
        destination_ip_groups = optional(list(string)),
        destination_fqdns     = optional(list(string)),
        protocols             = list(string)
      }))
    })))
    public_ip_zones = optional(list(number))
    sku_tier        = string
    zones           = optional(list(number))
  })
  default = null
}

// Firewall Policy Rule Collection Group
variable "firewall_policy_rule_collection_group_priority" {
  description = "(Required) The priority of the Firewall Policy Rule Collection Group. The range is 100-65000."
  type        = number
}

variable "application_rule_collection" {
  description = "(Optional) The Application Rule Collection to use in this Firewall Policy Rule Collection Group."
  type = list(object({
    name     = string
    action   = string
    priority = number
    rule = list(object({
      name        = string
      description = optional(string)
      protocols = optional(list(object({
        type = string
        port = number
      })))
      http_headers = optional(list(object({
        name  = string
        value = string
      })))
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
      destination_addresses = optional(list(string))
      destination_urls      = optional(list(string))
      destination_fqdns     = optional(list(string))
      destination_fqdn_tags = optional(list(string))
      terminate_tls         = optional(bool)
      web_categories        = optional(list(string))
    }))
  }))
  default = []
}

variable "network_rule_collection" {
  description = "(Optional) The Network Rule Collection to use in this Firewall Policy Rule Collection Group."
  type = list(object({
    name     = string
    action   = string
    priority = number
    rule = list(object({
      name                  = string
      description           = optional(string)
      protocols             = list(string)
      destination_ports     = list(string)
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
      destination_addresses = optional(list(string))
      destination_fqdns     = optional(list(string))
    }))
  }))
  default = []

}

variable "nat_rule_collection" {
  description = "(Optional) The NAT Rule Collection to use in this Firewall Policy Rule Collection Group."
  type = list(object({
    name     = string
    action   = string
    priority = number
    rule = list(object({
      name               = string
      description        = optional(string)
      protocols          = list(string)
      source_addresses   = optional(list(string))
      source_ip_groups   = optional(list(string))
      destination_ports  = optional(list(string))
      translated_address = optional(string)
      translated_port    = number
      translated_fqdn    = optional(string)
    }))
  }))
  default = []
}
