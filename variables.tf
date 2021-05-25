
#--------------------------------------------------------------
# Deployment variables 
#--------------------------------------------------------------

variable "prefix" {
    type        = string
    description = "The prefix that should be used for resources"
}

#Naming (env)
variable "env" {
    type        = string
    description = "The env should be for resource group name"
}
variable "location" {
    description = "The region"
    default     = "centralus"
}

# Virtual Address Space 

variable "smtr_hubns_vnet" {
    default     = "smtr_hub_vnet"
    description = "Virtual network event hub name"
}

variable "vnet_hub_address_space" {
    type        =string
    description = "Virtual address space"
}

variable "subnet_hub_name" {
    type        = string
    description = "Virtual Network name"
}

variable "subnet_hub_address_prefix" {
    type        = string
    description = "Subnet address prefix"
}

# Azure virtual Network details for databricks 
variable "az_databricks_vnet_name" {
    type        =  string
    description = "Virtual Network name"
}

variable "vnet_dtbricks_address_space" {
    type        = string
    description = "virtual network address space"
}

variable "az_subnet_services_name" {
    type        = string
    description = "virtual subnet name "
}

variable "vnet_sub_services_address_space" {
    type        = string
    description = "Virtual subnet address space"
}

variable "az_public_subnet_name" {
    type        = string
    description = "virtual subnet name "
}

variable "subnet_public_address_prefix" {
    type        = string
    description = "Virtual subnet address space"
}

variable "az_private_subnet_name" {
    type        = string
    description = "virtual subnet name "
}

variable "subnet_private_address_prefix" {
    type        = string
    description = "Virtual subnet address space"
}

variable "az_public_name" {
    type        = string
    description = "Public ip name"
}

variable "az_pub_sku" {
    type        = string
    description = "public ip sku type standard/Basic"
}

#variable "az_pub_alloc_method" {
#    default     = "Static"
#    description = "Public ip allocation method Static\Dynamic"
#}

variable "az_pub_ip_ver" {
    type        = string
    description = "public ip address ipv4 version"
}

# Azure vnet peering variables 

variable "az_peering_name" {
    type        =  string
    description = "virtual network peering name"
}

variable "az_peering_name1" {
    type        =  string
    description = "virtual network peering name"
}
# Azure route table variables 
variable "az_rout_tab_name" {
    type        = string
    description = "Route Table name"
}

variable "route_name" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix" {
    type        = string
    description = "Route addres prefix "
}
variable "route_next_hop_in_ip_address" {
    type        = string
    description = "Route next hop in ip address range "
}
variable "route_next_hop_type" {
    type        = string
    description = "Route next hop type virtual appliance or internet "
}

variable "route_name1" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix1" {
    type        = string
    description = "Route addres prefix "
}
variable "route_next_hop_type1" {
    type        = string
    description = "Route next hop type virtual appliance or internet "
}

variable "route_name2" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix2" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name3" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix3" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name4" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix4" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name5" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix5" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name6" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix6" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name7" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix7" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name8" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix8" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name9" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix9" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name10" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix10" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name11" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix11" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name12" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix12" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name13" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix13" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name14" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix14" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name15" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix15" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name16" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix16" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name17" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix17" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name18" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix18" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name19" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix19" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name20" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix20" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name21" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix21" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name22" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix22" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name23" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix23" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name24" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix24" {
    type        = string
    description = "Route addres prefix "
}

variable "route_name25" {
    type        = string
    description = "Route name "
}
variable "route_address_prefix25" {
    type        = string
    description = "Route addres prefix "
}

# Azure Firewall variables
variable "az_firewall_name" {
    type        = string
    description = "azure firewall name"
}

variable "az_conf_firwal_name" {
    type        =  string
    description = "Azure configuration firewall name"
}

#azure Firewall rule variables
variable "az_net_rul_name" {
    type        = string
    description = "Azure Network rule collection name"
}

variable "az_net_rul_prio" {
    type        = number
    description = "Network Rule periority "
}

variable "az_net_rul_act" {
    type        = string
    description = "Network rule action Allow/Deny"
}

variable "az_rule_name" {
    type        = string
    description = "Network rule name"
}

variable "az_rule_dest_port" {
    type        = number
    description = "network rule port number"
}

variable "az_rule_protoc" {
    type        = string
    description = "Network rule protocol TCP/UDP"
}

variable "az_rule_dest1_address" {
    type        = string
    description = "Destination address"
}

variable "az_rule_dest2_address" {
    type        = string
    description = "Destination address"
}

# Azure Other rules
variable "az_rule_others_name" {
    type = string
}
variable "az_rule_other_dest1_address" {
    type = string
}

variable "az_rule_other_dest2_address" {
    type = string
}
variable "az_rule_other_dest3_address" {
    type = string
}

# Azure mysql rule details
variable "az_rule_mysql_name" {
    type = string
}

variable "az_rule_mysql_dest_port" {
    type = number
}
variable "az_rule_mysql_dest1_address" {
    type = string
}
variable "az_rule_mysql_dest2_address" {
    type = string
}
variable "az_rule_mysql_dest3_address" {
    type = string
}
variable "az_rule_mysql_dest4_address" {
    type = string
}

# application Rule Collection
variable "az_appl_rule_name" {
    type        = string 
}
variable "az_appl_rule_databrick_spark_blob_stor" {
    type        = string
}

variable "az_appl_rule_databricks_spa_target_fdq1" {
    type        = string 
}

variable "az_appl_rule_databricks_spa_target_fdq2" {
    type        = string 
}
variable "az_appl_rule_port" {
    type        = number 
}

variable "az_apple_rule_type" {
    type        = string 
}

variable "az_appl_rule_databrick_artif_blob_stor" {
    type        = string
}

variable "az_appl_rule_databricks_arti_tar_fdq" {
    type        = string 
}

variable "az_appl_rule_databricks_arti_tar_fdq1" {
    type        = string 
}

variable "az_appl_rule_databricks_arti_tar_fdq2" {
    type        = string 
}
variable "az_appl_rule_databricks_arti_tar_fdq3" {
    type        = string 
}
variable "az_appl_rule_databricks_arti_tar_fdq4" {
    type        = string 
}
variable "az_appl_rule_databricks_arti_tar_fdq5" {
    type        = string 
}
variable "az_appl_rule_databricks_arti_tar_fdq6" {
    type        = string 
}

variable "az_appl_rule_databricks_arti_tar_fdq7" {
    type        = string 
}

variable "az_appl_rule_databricks_arti_tar_fdq8" {
    type        = string 
}

variable "az_appl_rule_dtb_dbfs" {
    type        = string
}
variable "az_appl_rule_dtb_dbfs_tar_fdq" {
    type        = string 
}

variable "az_appl_rule_evthub_endp" {
    type        = string 
}

variable "az_appl_rule_evhub_endp_tar_fdq" {
    type        = string 
}

variable "az_appl_rule_evhub_endp_tar_fdq1" {
    type        = string 
}

variable "az_appl_rule_pyrepo" {
    type        = string 
}

variable "az_appl_rule_pyrepo_tar_fdq" {
    type        = string 
}
variable "az_appl_rule_pyrepo_tar_fdq1" {
    type        = string 
}
variable "az_appl_rule_pyrepo_tar_fdq2" {
    type        = string 
}

variable "az_appl_rule_gang" {
    type        = string 
}

variable "az_appl_rule_gang_tar_fdq" {
    type        = string
}

variable "az_appl_rule_gang_tar_fdq1" {
    type        = string
}

variable "az_appl_rule_metasto" {
    type        = string
}

variable "az_appl_rule_metasto_tar_fdq" {
    type        = string 
}

variable "az_appl_rule_metasto_tar_fdq1" {
    type        = string 
}

variable "az_appl_rule_metasto_tar_fdq2" {
    type        = string 
}

variable "az_appl_rule_other" {
    type        = string 
}

variable "az_appl_rule_other_tar_fdq" {
    type        = string 
}

#private end point variables
variable "az_pr_endpnt_name" {
    type        = string 
}

variable "az_pr_service_name" {
    type        = string
}



variable "az_pr_endp_stor_name" {
    type        = string 
}

variable "az_pr_service_stor_name" {
    type        = string
}


variable "databricks" {
    type        = string
    description = "deploy databricks or not?"
}

variable "eventhub" {
    type        = string
    description = "deploy eventhub or not?"
}

#Tags
variable "az_tags" {
    type        = map
    description = "The default tags for resources and resources groups"
}

#Azure Storage

//variable "az_stor_account_name" {
//    type        = string
//    description = "Azure Storage Account name"
//}
variable "az_stor_acc_tier" {
    type        = string
    description = "Azure Storage Account Tier (Std/Premium)"
}

variable "az_stor_repl_type" {
    type        = string
    description = "Azure Storage Replication Type (GRS/LRS/RA-GRS)"
}

variable "az_stor_kind" {
    type        = string
    description = "Azure Storage Account Kind (V1/V2/Blob)"
}

variable "az_stor_tier" {
    type        = string
    description = "Azure Storage Access Tier (Hot/Cool)"
}

variable "az_stor_secure" {
    type        = string
    description = "Is Azure Secure Transfer Required?"
}

#Storage Container Access Tier
variable "az_conta_acce_tier" {
    type        = string
    description = "Azure Storage Container Access Tier"
}

variable "az_container_name" {
    type        = string 
    description = "azure storage account container name"
}
#Azure Event Hubs Namespace

variable "az_event_hubns_name" {
    type = string
    description = "The Azure Event Hubns name"
}

variable "az_hubns_sku" {
    type        = string
    description = "The Azure Event Hubs Sku (Basic/Standard)"
}

variable "az_hubns_maxunits" {
    type        = string
    description = "If  auto_inflate_enabled is set to True, defines maximum throughput units"
}

variable "az_hub_inflate" {
    type        = string
    description = "Should we enable auto_inflate on Event Hubs namespace? (true/false)"
}

variable "az_hubns_capacity" {
    type        = string
    description = "The Azure Event Hubs capacity (throughput units). Only applicable if SKU is Standard"
}

variable "az_hub_partcount" {
    type        = string
    description = "Azure Event Partition Count (1-32)"
}

variable "az_hub_retention" {
    type        = string
    description = "Azure Event Hub Message Retention (days)"
}

variable "az_hub_capture" {
    type        = string
    description = "Should we enable capturing to Azure Storage?"
}

variable "az_event_hub_name" {
    type        = string 
    description = "should we give event hub name"
}

#Azure DataBricks
variable "az_db_name" {
    type        = string 
    description = "Databricks name "
}

variable "az_db_cluster_name" {
    type        = string 
    description = "databricks cluster name "
}

variable "spark_version" {
    description = "Spark Runtime Version for databricks clusters"
    default     = "8.1.x-scala2.12"
}
variable "node_type_id" {
    description = "Type of worker nodes for databricks clusters"
    default     = "Standard_DS3_v2"
}

variable "notebook_path" {
    description = "Path to a notebook"
    default     = "/python_notebook"
}

variable "min_workers" {
    description = "Minimum workers in a cluster"
    default     = 2
}

variable "max_workers" {
    description = "Maximum workers in a cluster"
    default     = 8
}

#Azure Private DNS Zone variables 

variable "az_private_dns_name" {
    type        = string 
    description = "Azure private dns zone name"
}

variable "az_private_dns_record_name" {
    type        = string 
    description = "Azure private dns zone record name"
}

variable "az_private_dns_records" {
    type        = string 
    description = "Azure private dns zone records"
}

variable "az_private_dns_ttl" {
    type        = string 
    description = "Azure private dns zone ttl values"
}

variable "az_private_dns_record_name1" {
    type        = string 
    description = "Azure private dns zone record name"
}

variable "az_private_dns_records1" {
    type        = string 
    description = "Azure private dns zone records"
}

variable "az_private_dns_name1" {
    type        = string 
    description = "Azure private dns zone name"
}

variable "az_private_dns_record_name2" {
    type        = string 
    description = "Azure private dns zone record name"
}

variable "az_private_dns_ttl1" {
    type        = string 
    description = "Azure private dns zone ttl values"
}
