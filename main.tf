
provider "databricks" {
    azure_workspace_resource_id = azurerm_databricks_workspace.az_workspace.id
    azure_client_id             = var.client_id
    azure_client_secret         = var.client_secret
    azure_tenant_id             = var.tenant_id
}


#----------------------------------------------------------------------------------------------
#
# Create Resource Group
#
#-----------------------------------------------------------------------------------------------
resource "random_string" "rndstr" {
    length  = 6
    lower   = true
    number  = true
    upper   = false
    special = false
}

resource "azurerm_resource_group" "az_rg" {
    name                        = "${var.prefix}-${var.env}-rg"
    location                    = var.location
    tags                        = var.az_tags
}

#--------------------------------------------------------------------------------------
#
#   Virtual Networks and Subnets 
#
#---------------------------------------------------------------------------------------
resource "azurerm_virtual_network" "az_databricks_vnet" {
    name                = var.az_databricks_vnet_name
    location            = azurerm_resource_group.az_rg.location
    resource_group_name = azurerm_resource_group.az_rg.name
    address_space       = [var.vnet_dtbricks_address_space]

    tags                 = var.az_tags
}

# Azure subnet for az_services from az_databricks_vnet
resource "azurerm_subnet" "az_sub_services" {
    name                        = var.az_subnet_services_name
    resource_group_name         = azurerm_resource_group.az_rg.name
    address_prefixes            = [ var.vnet_sub_services_address_space ]
    virtual_network_name        = azurerm_virtual_network.az_databricks_vnet.name

    enforce_private_link_endpoint_network_policies = true

}

resource "azurerm_network_security_group" "az_nsg" {
    name                = "${var.prefix}-nsg"
    location            = azurerm_resource_group.az_rg.location
    resource_group_name = azurerm_resource_group.az_rg.name
    tags                 = var.az_tags
}

resource "azurerm_subnet" "az_sub_public" {
    name                 = var.az_public_subnet_name
    resource_group_name  = azurerm_resource_group.az_rg.name
    virtual_network_name = azurerm_virtual_network.az_databricks_vnet.name
    address_prefixes     = [var.subnet_public_address_prefix]

    enforce_private_link_endpoint_network_policies = true

    delegation {
        name = "databricks"
        service_delegation {
        name = "Microsoft.Databricks/workspaces"
        actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
            "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
            "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
        }
    }
}

resource "azurerm_subnet_network_security_group_association" "az_public_nsg" {
    subnet_id                 = azurerm_subnet.az_sub_public.id
    network_security_group_id = azurerm_network_security_group.az_nsg.id
}

resource "azurerm_subnet" "az_sub_private" {
    name                    = var.az_private_subnet_name
    resource_group_name     = azurerm_resource_group.az_rg.name
    virtual_network_name    = azurerm_virtual_network.az_databricks_vnet.name
    address_prefixes        = [var.subnet_private_address_prefix]

    enforce_private_link_endpoint_network_policies = true

    delegation {
        name = "databricks"
        service_delegation {
        name = "Microsoft.Databricks/workspaces"
        actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
            "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
        }
    }
}

resource "azurerm_subnet_network_security_group_association" "az_private_nsg" {
    subnet_id                 = azurerm_subnet.az_sub_private.id
    network_security_group_id = azurerm_network_security_group.az_nsg.id
}

# Another Virtual Network creation for Firewall/ Route Table

resource "azurerm_virtual_network" "az_controlpanel" {
    name                        = var.smtr_hubns_vnet
    resource_group_name         = azurerm_resource_group.az_rg.name 
    location                    = azurerm_resource_group.az_rg.location
    address_space               = [ var.vnet_hub_address_space]
    tags                        = var.az_tags
}



resource "azurerm_subnet" "az_sub_hub" {
    name                        = var.subnet_hub_name
    resource_group_name         = azurerm_resource_group.az_rg.name
    virtual_network_name        = azurerm_virtual_network.az_controlpanel.name
    address_prefixes            = [ var.subnet_hub_address_prefix ]
}


#------------------------------------------------------------------------------------------
#
#  Public IP Generation in static 
#
#-------------------------------------------------------------------------------------------

resource "azurerm_public_ip" "az_pip" {
    name                        = var.az_public_name
    resource_group_name         = azurerm_resource_group.az_rg.name
    location                    = azurerm_resource_group.az_rg.location
    sku                         = var.az_pub_sku
    allocation_method           = "Static"
    ip_version                  = var.az_pub_ip_ver
    tags                        = var.az_tags
}


#-------------------------------------------------------------------------------------------
# Virtual Networking Peering  Hub vnets to Databricks
#-------------------------------------------------------------------------------------------
resource "azurerm_virtual_network_peering" "az_peering" {
    name                                = var.az_peering_name
    resource_group_name                 = azurerm_resource_group.az_rg.name
    virtual_network_name                = azurerm_virtual_network.az_controlpanel.name
    remote_virtual_network_id           = azurerm_virtual_network.az_databricks_vnet.id 
    allow_forwarded_traffic             = true
    allow_virtual_network_access        = true 
    use_remote_gateways                 = false
    allow_gateway_transit               = false
}

resource "azurerm_virtual_network_peering" "az_peering1" {
    name                                = var.az_peering_name1
    resource_group_name                 = azurerm_resource_group.az_rg.name
    virtual_network_name                = azurerm_virtual_network.az_databricks_vnet.name
    remote_virtual_network_id           = azurerm_virtual_network.az_controlpanel.id 
    allow_forwarded_traffic             = true
    allow_virtual_network_access        = true 
    use_remote_gateways                 = false 
    allow_gateway_transit               = false
}

#------------------------------------------------------------------------------------------------
#
#  Route Table configuration Setup
#
#------------------------------------------------------------------------------------------------
resource "azurerm_route_table" "az_route" {
    name                                = var.az_rout_tab_name
    resource_group_name                 = azurerm_resource_group.az_rg.name
    location                            = azurerm_resource_group.az_rg.location
    disable_bgp_route_propagation       = false
    tags                                = var.az_tags

    route {
        name                   = var.route_name
        address_prefix         = var.route_address_prefix 
        next_hop_in_ip_address = var.route_next_hop_in_ip_address 
        next_hop_type          = var.route_next_hop_type
    }

    route {
        name           = var.route_name1
        address_prefix = var.route_address_prefix1
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name2
        address_prefix = var.route_address_prefix2
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name3
        address_prefix = var.route_address_prefix3
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name4
        address_prefix = var.route_address_prefix4
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name5
        address_prefix = var.route_address_prefix5
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name6
        address_prefix = var.route_address_prefix6
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name7
        address_prefix = var.route_address_prefix7
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name8
        address_prefix = var.route_address_prefix8
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name9
        address_prefix = var.route_address_prefix9
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name10
        address_prefix = var.route_address_prefix10
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name11
        address_prefix = var.route_address_prefix11
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name12
        address_prefix = var.route_address_prefix12
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name13
        address_prefix = var.route_address_prefix13
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name14
        address_prefix = var.route_address_prefix14
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name15
        address_prefix = var.route_address_prefix15
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name16
        address_prefix = var.route_address_prefix16
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name17
        address_prefix = var.route_address_prefix17
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name18
        address_prefix = var.route_address_prefix18
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name19
        address_prefix = var.route_address_prefix19
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name20
        address_prefix = var.route_address_prefix20
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name21
        address_prefix = var.route_address_prefix21
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name22
        address_prefix = var.route_address_prefix22
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name23
        address_prefix = var.route_address_prefix23
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name24
        address_prefix = var.route_address_prefix24
        next_hop_type  = var.route_next_hop_type1
    }

    route {
        name           = var.route_name25
        address_prefix = var.route_address_prefix25
        next_hop_type  = var.route_next_hop_type1
    }
}

resource "azurerm_subnet_route_table_association" "az_sub_publ_routetb" {
    subnet_id                           = azurerm_subnet.az_sub_public.id 
    route_table_id                      = azurerm_route_table.az_route.id 
    depends_on                          = [azurerm_subnet.az_sub_public]  
}

resource "azurerm_subnet_route_table_association" "az_sub_priv_routetb" { 
    subnet_id                           = azurerm_subnet.az_sub_private.id 
    route_table_id                      = azurerm_route_table.az_route.id 
    depends_on                          = [azurerm_subnet.az_sub_private]
}
                                                                                                                                                                                            
#-------------------------------------------------------------------------------------------
#
#  Firewall Configuration 
#
#---------------------------------------------------------------------------------------------
resource "azurerm_firewall" "az_firewall" {
    name                                = var.az_firewall_name
    resource_group_name                 = azurerm_resource_group.az_rg.name
    location                            = azurerm_resource_group.az_rg.location

    ip_configuration {
        name                            = var.az_conf_firwal_name 
        public_ip_address_id            = azurerm_public_ip.az_pip.id
        subnet_id                       = azurerm_subnet.az_sub_hub.id 
    }

    tags                                = var.az_tags
}

resource "azurerm_firewall_network_rule_collection" "az_network_rule" {
    name                                = var.az_net_rul_name
    azure_firewall_name                 = azurerm_firewall.az_firewall.name
    resource_group_name                 = azurerm_resource_group.az_rg.name
    priority                            = var.az_net_rul_prio
    action                              = var.az_net_rul_act

    rule {
        name                    = var.az_rule_name
        source_addresses        = [ var.subnet_private_address_prefix,var.subnet_public_address_prefix]
        destination_ports       = [ var.az_rule_dest_port ]
        protocols               = [ var.az_rule_protoc ]
        destination_addresses   = [ var.az_rule_dest1_address,var.az_rule_dest2_address ]
    }

    rule {
        name                    = var.az_rule_others_name
        source_addresses        = [ var.subnet_private_address_prefix,var.subnet_public_address_prefix]
        destination_ports       = [ var.az_rule_dest_port ]
        protocols               = [ var.az_rule_protoc ]
        destination_addresses   = [ var.az_rule_other_dest1_address,var.az_rule_other_dest2_address,var.az_rule_other_dest3_address ]
    }

    rule {
        name                    = var.az_rule_mysql_name
        source_addresses        = [ var.subnet_private_address_prefix,var.subnet_public_address_prefix]
        protocols               = [ var.az_rule_protoc ]
        destination_ports       = [ var.az_rule_mysql_dest_port ]
        destination_addresses   = [ var.az_rule_mysql_dest1_address,var.az_rule_mysql_dest2_address,var.az_rule_mysql_dest3_address,var.az_rule_mysql_dest4_address ]
    }

}

resource "azurerm_firewall_application_rule_collection" "az_application_rule" {
    name                                = var.az_appl_rule_name
    azure_firewall_name                 = azurerm_firewall.az_firewall.name
    resource_group_name                 = azurerm_resource_group.az_rg.name
    priority                            = var.az_net_rul_prio
    action                              = var.az_net_rul_act

    rule {
        name                    = var.az_appl_rule_databrick_spark_blob_stor
        source_addresses        = [ var.subnet_public_address_prefix, var.subnet_private_address_prefix ]
        target_fqdns            = [ var.az_appl_rule_databricks_spa_target_fdq1,var.az_appl_rule_databricks_spa_target_fdq2]
        protocol {
            port                = var.az_appl_rule_port
            type                = var.az_apple_rule_type
        }
    }
    rule {
        name                    = var.az_appl_rule_databrick_artif_blob_stor
        source_addresses        = [ var.subnet_public_address_prefix, var.subnet_private_address_prefix ]
        target_fqdns            = [ var.az_appl_rule_databricks_arti_tar_fdq,var.az_appl_rule_databricks_arti_tar_fdq1,var.az_appl_rule_databricks_arti_tar_fdq2,var.az_appl_rule_databricks_arti_tar_fdq3,var.az_appl_rule_databricks_arti_tar_fdq4,var.az_appl_rule_databricks_arti_tar_fdq5,var.az_appl_rule_databricks_arti_tar_fdq6,var.az_appl_rule_databricks_arti_tar_fdq7,var.az_appl_rule_databricks_arti_tar_fdq8]
        protocol {
            port                = var.az_appl_rule_port
            type                = var.az_apple_rule_type
        }
    }

    rule {
        name                    = var.az_appl_rule_dtb_dbfs
        source_addresses        = [ var.subnet_public_address_prefix, var.subnet_private_address_prefix ]
        target_fqdns            = [ var.az_appl_rule_dtb_dbfs_tar_fdq]
        protocol {
            port                = var.az_appl_rule_port
            type                = var.az_apple_rule_type
        }
    }

    rule {
        name                    = var.az_appl_rule_evthub_endp
        source_addresses        = [ var.subnet_public_address_prefix, var.subnet_private_address_prefix ]
        target_fqdns            = [ var.az_appl_rule_evhub_endp_tar_fdq,var.az_appl_rule_evhub_endp_tar_fdq1]
        protocol {
            port                = var.az_appl_rule_port
            type                = var.az_apple_rule_type
        }
    }

    rule {
        name                    = var.az_appl_rule_pyrepo
        source_addresses        = [ var.subnet_public_address_prefix, var.subnet_private_address_prefix ]
        target_fqdns            = [ var.az_appl_rule_pyrepo_tar_fdq,var.az_appl_rule_pyrepo_tar_fdq1,var.az_appl_rule_pyrepo_tar_fdq2]
        protocol {
            port                = var.az_appl_rule_port
            type                = var.az_apple_rule_type
        }
    }

    rule {
        name                    = var.az_appl_rule_gang
        source_addresses        = [ var.subnet_public_address_prefix, var.subnet_private_address_prefix ]
        target_fqdns            = [ var.az_appl_rule_gang_tar_fdq,var.az_appl_rule_gang_tar_fdq1]
        protocol {
            port                = var.az_appl_rule_port
            type                = var.az_apple_rule_type
        }
    }

    rule {
        name                    = var.az_appl_rule_metasto
        source_addresses        = [ var.subnet_public_address_prefix, var.subnet_private_address_prefix ]
        target_fqdns            = [ var.az_appl_rule_metasto_tar_fdq,var.az_appl_rule_metasto_tar_fdq1,var.az_appl_rule_metasto_tar_fdq2]
        protocol {
            port                = var.az_appl_rule_port
            type                = var.az_apple_rule_type
        }
    }

    rule {
        name                    = var.az_appl_rule_other
        source_addresses        = [ var.subnet_public_address_prefix, var.subnet_private_address_prefix ]
        target_fqdns            = [ var.az_appl_rule_other_tar_fdq]
        protocol {
            port                = var.az_appl_rule_port
            type                = var.az_apple_rule_type
        }
    }
}

#-------------------------------------------------------------------------------------
#
#  Two Private end points configuration to Azure Services Vnet
#
#--------------------------------------------------------------------------------------

resource "azurerm_private_endpoint" "az_pr_enp_enhub" {
    name                        = var.az_pr_endpnt_name
    location                    = azurerm_resource_group.az_rg.location
    resource_group_name         = azurerm_resource_group.az_rg.name
    subnet_id                   = azurerm_subnet.az_sub_services.id
    tags                        = var.az_tags
    private_service_connection {
        name                            = var.az_pr_service_name
        private_connection_resource_id  = azurerm_eventhub_namespace.mdp_hubns.id
        subresource_names               = [ "namespace" ]
        is_manual_connection            = false
        
    }
}

resource "azurerm_private_endpoint" "az_pr_enp_storage" {
    name                        = var.az_pr_endp_stor_name
    location                    = azurerm_resource_group.az_rg.location
    resource_group_name         = azurerm_resource_group.az_rg.name
    subnet_id                   = azurerm_subnet.az_sub_services.id
    tags                        = var.az_tags
    private_service_connection {
        name                            = var.az_pr_service_stor_name
        private_connection_resource_id  = azurerm_storage_account.az_stor.id
        subresource_names               = [ "blob" ]
        is_manual_connection            = false
        
    }
}

#-------------------------------------------------------------------------------------
#Azure Event Hub Namespace
#
#-------------------------------------------------------------------------------------

resource "azurerm_eventhub_namespace" "mdp_hubns" {
    name                        = "${var.az_event_hubns_name}-${var.env}"
    resource_group_name         = azurerm_resource_group.az_rg.name
    location                    = azurerm_resource_group.az_rg.location
    sku                         = var.az_hubns_sku
    capacity                    = var.az_hubns_capacity
    auto_inflate_enabled        = (var.az_hubns_sku != "Basic" ? var.az_hub_inflate : "false")
    maximum_throughput_units    = (var.az_hub_inflate != "false" ? var.az_hubns_maxunits : "0")
    tags                        = var.az_tags
}

#Azure Event Hub

resource "azurerm_eventhub" "mdp_hub" {
    name                        = var.az_event_hub_name
    namespace_name              = azurerm_eventhub_namespace.mdp_hubns.name 
    resource_group_name         = azurerm_resource_group.az_rg.name
    partition_count             = var.az_hub_partcount
    message_retention           = var.az_hub_retention
}

#--------------------------------------------------------------------------------------
# Create Databricks Workspace
#--------------------------------------------------------------------------------------

resource "azurerm_databricks_workspace" "az_workspace" {
    name                        = "${var.prefix}-${var.az_db_name}-${var.env}"
    resource_group_name         = azurerm_resource_group.az_rg.name
    location                    = azurerm_resource_group.az_rg.location
    sku                         = "premium"
    managed_resource_group_name = "${var.prefix}-${var.env}-${var.az_db_name}-workspace-rg"
    
    custom_parameters {
        no_public_ip        = true 
        virtual_network_id  = azurerm_virtual_network.az_databricks_vnet.id
        public_subnet_name  = azurerm_subnet.az_sub_public.name
        private_subnet_name = azurerm_subnet.az_sub_private.name
    }

    tags                 = var.az_tags
}

#To create databricks cluster
resource "databricks_cluster" "shared_autoscaling" {
    cluster_name            = "${var.prefix}-${var.env}-${var.az_db_cluster_name}"
    spark_version           = var.spark_version
    node_type_id            = var.node_type_id
    autotermination_minutes = 120
    autoscale {
        min_workers = var.min_workers
        max_workers = var.max_workers
    }

    library {
        maven {
            coordinates = "com.microsoft.azure:azure-eventhubs-spark_2.12:2.3.18"
        }   
    }

    library {
        maven {
            coordinates = "org.apache.spark:spark-avro_2.12:3.1.1"
        }   
    }
}

#------------------------------------------------------------------------------------
#
# Create Storage account for Data Lake store
#
#------------------------------------------------------------------------------------
resource "azurerm_storage_account" "az_stor" {
    name                        = "${var.prefix}sa${var.env}"
    resource_group_name         = azurerm_resource_group.az_rg.name
    location                    = azurerm_resource_group.az_rg.location
    account_tier                = var.az_stor_acc_tier
    account_replication_type    = var.az_stor_repl_type
    account_kind                = var.az_stor_kind
    access_tier                 = var.az_stor_tier
    enable_https_traffic_only   = var.az_stor_secure
    tags                        = var.az_tags
    min_tls_version             = "TLS1_2"
    is_hns_enabled              = true
    //nfsv3_enabled               = false
}

resource "azurerm_storage_container" "az_stor" {
    name                        = var.az_container_name
    storage_account_name        = azurerm_storage_account.az_stor.name
    container_access_type       = var.az_conta_acce_tier
}


#--------------------------------------------------------------------------------------
#
# Private DNS Zone 
#
#--------------------------------------------------------------------------------------

resource "azurerm_private_dns_zone" "az_private_dns" {
    name                    = var.az_private_dns_name
    resource_group_name     = azurerm_resource_group.az_rg.name
    tags                    = var.az_tags
}

resource "azurerm_private_dns_a_record" "az_private_dns_record1" {
    name                    = var.az_private_dns_record_name
    zone_name               = azurerm_private_dns_zone.az_private_dns.name
    resource_group_name     = azurerm_resource_group.az_rg.name
    ttl                     = var.az_private_dns_ttl
    records                 = [ var.az_private_dns_records ]    
}

resource "azurerm_private_dns_a_record" "az_private_dns_record2" {
    name                    = var.az_private_dns_record_name1
    zone_name               = azurerm_private_dns_zone.az_private_dns.name
    resource_group_name     = azurerm_resource_group.az_rg.name
    ttl                     = var.az_private_dns_ttl
    records                 = [ var.az_private_dns_records1 ]
    
}

resource "azurerm_private_dns_zone" "az_private_dns1" {
    name                    = var.az_private_dns_name1
    resource_group_name     = azurerm_resource_group.az_rg.name
    tags                    = var.az_tags
}

resource "azurerm_private_dns_a_record" "az_private_dns1" {
    name                    = var.az_private_dns_record_name2
    zone_name               = azurerm_private_dns_zone.az_private_dns1.name
    resource_group_name     = azurerm_resource_group.az_rg.name
    ttl                     = var.az_private_dns_ttl1
    records                 = [ var.az_private_dns_records1 ]
}



