locals {
  network_security_group_name = module.resource_names["network_security_group"].minimal_random_suffix
  firewall_id                 = module.hub_vnet.firewall_ids["hub_firewall"][0]
  subnet_id                   = lookup(lookup(module.hub_vnet.vnet_subnet_name_id_map, "hub_network", null), "snet1", null)
  network_security_group_id   = module.network_security_group.network_security_group_id
}
