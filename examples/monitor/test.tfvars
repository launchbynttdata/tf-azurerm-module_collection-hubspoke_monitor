logical_product_service = "log"
logical_product_family  = "launch"
class_env               = "sandbox"
instance_env            = 0
instance_resource       = 0
location                = "eastus2"
resource_names_map = {
  resource_group = {
    name       = "rg"
    max_length = 80
  }
  storage_account = {
    name       = "sa"
    max_length = 24
  }
  network_security_group = {
    name       = "nsg"
    max_length = 80
  }
  hubfirewall = {
    name       = "fw"
    max_length = 80
  }
  log_analytics_workspace = {
    name       = "lw"
    max_length = 80
  }
  monitor_diagnostic_setting = {
    name       = "ds"
    max_length = 80
  }
  network_watcher_flow_log = {
    name       = "nwfl"
    max_length = 80
  }
  public_ip = {
    name       = "pip"
    max_length = 80
  }
  hub_vnet = {
    name       = "hvnet"
    max_length = 80
  }
  firewall_policy = {
    name       = "fwpol"
    max_length = 80
  }
  fw_plcy_rule_colln_grp = {
    name       = "fwpolrcg"
    max_length = 80
  }
  custom_diagnostic_settings = {
    name       = "customds"
    max_length = 80
  }
  hub_vnet_ip_configuration = {
    name       = "hubvnetipconfig"
    max_length = 80
  }
}
log_analytics_workspace_sku    = "PerGB2018"
log_analytics_destination_type = "Dedicated"
retention_in_days              = 30
identity                       = null
enabled_log = [{
  category = "AZFWApplicationRule"
  },
  {
    category = "AZFWNetworkRule"
  },
  {
    category = "AZFWDnsQuery"
  },
  {
    category = "AZFWNatRule"
  },
  {
    category = "AZFWNatRule"
}]
metric = {
  category = "AllMetrics"
  enabled  = true
}
account_tier                     = "Standard"
account_replication_type         = "LRS"
enable_https_traffic_only        = true
create_network_watcher           = false
network_watcher_flow_log_enabled = true
retention_policy = {
  enabled = true
  days    = 30
}
traffic_analytics = {
  enabled             = true
  interval_in_minutes = 10
}

//for hub network module
network = {
  use_for_each    = false
  address_space   = ["10.0.0.0/16"]
  subnet_names    = ["snet1"]
  subnet_prefixes = ["10.0.2.0/24"]
}
firewall = {
  logs_destinations_ids = []
  subnet_cidr           = "10.0.1.0/24"
  additional_public_ips = []
  sku_tier              = "Standard"
  ip_configuration_name = "AzureFirewallIpConfiguration"
}
firewall_policy_rule_collection_group_priority = 100
application_rule_collection                    = []
network_rule_collection                        = []
nat_rule_collection                            = []
