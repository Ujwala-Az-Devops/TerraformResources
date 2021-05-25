#--------------------------------------------------------------
# Deployment settings 
#--------------------------------------------------------------

# Azure principal

#old sp details

client_id           = ""    # Application ID
client_secret       = ""      # Secret password ID
subscr_id           = ""    # Subscription ID
tenant_id           = ""    # Tenant ID



# Azure region

location = "centralus"

# Azure tags

az_tags = {
    environment = "dev"
}

# Naming convention

prefix = "abc"

env    = "dev"

#--------------------------------------------------------------
# What should be deployed?
#--------------------------------------------------------------
databricks       = true  # Azure DataBricks
eventhub         = true  # Azure EventHub

#--------------------------------------------------------------
# Data Lake Storage settings | uhgmdp.com
#--------------------------------------------------------------

//az_stor_account_name    = "sa"         # Storage account name
az_stor_acc_tier        = "Premium"             # Standard or Premium
az_stor_repl_type       = "LRS"                 # Storage Replication Type
az_stor_kind            = "StorageV2"           # Storage Kind
az_stor_tier            = "Hot"                 # Tier (Cold/Hot/Archive)
az_stor_secure          = true                  # Secured Storage or not? (HTTPS only)

# Data Storage Container
az_conta_acce_tier      = "private"
az_container_name       = "medname"
# Azure DataBricks
#az_spark_sku        = "premium" # "standard/premium"
az_db_name          = "dataplatform"
az_db_cluster_name  = "cluster"

#--------------------------------------------------------------
# Event Hubs settings | uhgmdp.com
#--------------------------------------------------------------
az_event_hubns_name = "mdpdatastream"     # Event Hubns name
az_hubns_sku        = "Standard"            # Event Hubs SKU (Basic/Standard)
az_hubns_capacity   = "1"                   # Capacity (Throughput Units)
az_hub_inflate      = "false"               # Auto-inflate (applicable to Standard SKU)
az_hubns_maxunits   = "7"                   # Max number of units if inflate enabled
az_hub_partcount    = "1"                   # Event Hub Partition Count
az_hub_retention    = "1"                   # Event Hub Message Retention
az_hub_capture      = "false"               # Enable capture to Azure storage?

az_event_hub_name   = "testingconnection"
#-----------------------------------------------------------------
# Network variables
#------------------------------------------------------------------

# Virtual Networks details for event hub


smtr_hubns_vnet                     = "smtr_hub_vnet"
vnet_hub_address_space              = "***.**.*.*/16"
subnet_hub_name                     = "AzureFirewallSubnet"
subnet_hub_address_prefix           = "***.**.*.*/24"

# Virtual Network details for databricks 
az_databricks_vnet_name         = "databricks_vnet"
vnet_dtbricks_address_space     = "***.**.*.*/16"
az_subnet_services_name         = "az_services"
vnet_sub_services_address_space = "***.**.*.*/24"
az_public_subnet_name           = ""
subnet_public_address_prefix    = "***.**.*.*/24"
az_private_subnet_name          = "private_mdp"
subnet_private_address_prefix   = "***.**.*.*/24"


# Azure Public ip creation details
az_public_name                  = "fw_pip"
az_pub_sku                      = "Standard"
#az_pub_alloc_method             = "Static"
az_pub_ip_ver                   = "IPV4"

# Azure Virtual network peering details 
az_peering_name                 = "peerhubtodb"
az_peering_name1                = "peerdbtohub"


# Azure Route table details
az_rout_tab_name                = "cntpl-route-table"
#route details 
route_name                      = "to-controlplane-firewall"
route_address_prefix            = "0.0.0.0/0"
route_next_hop_in_ip_address    = "***.**.*.*"
route_next_hop_type             = "VirtualAppliance"

route_name1                     = "arprodcusa4.blob.core.windows.net"
route_address_prefix1           = "**.***.**.***/32"
route_next_hop_type1            = "Internet"

route_name2                     = "arprodcusa5.blob.core.windows.net"
route_address_prefix2           = "***.**.*.*/32"

route_name3                     = "artifactblobstorage"
route_address_prefix3           = "***.**.*.*0/32"

route_name4                     = "blobstorage1"
route_address_prefix4           = "***.**.*.*/32"

route_name5                     = "blobstorage1new"
route_address_prefix5           = "***.**.*.*/32"

route_name6                     = "blobstorage2"
route_address_prefix6           = "***.**.*.*/32"

route_name7                     = "blobstorage2new"
route_address_prefix7           = "***.**.*.*/32"

route_name8                     = "blobstorage3"
route_address_prefix8           = "***.**.*.*/32"

route_name9                     = "blobstorage3new"
route_address_prefix9           = "***.**.*.*/32"

route_name10                    = "dblogprodcentralus.blob.core.windows.net_ip1"
route_address_prefix10          = "***.**.*.*8/32"

route_name11                    = "dblogprodcentralus.blob.core.windows.net_ip2"
route_address_prefix11          = "***.**.*.*/32"

route_name12                    = "dblogprodcentralus.blob.core.windows.net_ip3"
route_address_prefix12          = "***.**.*.*/32"

route_name13                    = "dblogprodwestus.blob.core.windows.net"
route_address_prefix13          = "***.**.*.*/32"

route_name14                    = "dbstoragey3vxe6shnr5li.blob.core.windows.net"
route_address_prefix14          = "***.**.*.*/32"

route_name15                    = "Extendedinfrastructure"
route_address_prefix15          = "***.**.*.*/28"

route_name16                    = "mysqlilip1"
route_address_prefix16          = "***.**.*.*9/32"

route_name17                    = "mysqlip2"
route_address_prefix17          = "***.**.*.*2/32"

route_name18                    = "mysqlip3"
route_address_prefix18          = "***.**.*.*/32"

route_name19                    = "mysqlip4"
route_address_prefix19          = "***.**.*.*/32"

route_name20                    = "prod-centralusc2-observabilityeventhubs.servicebus.windows.net"
route_address_prefix20          = ***.**.*.*/32"

route_name21                    = "prod-westus-observabilityEventHubs.servicebus.windows.net"
route_address_prefix21          = "***.**.*.*/32"

route_name22                    = "to-central-us-databricks-scc-replay-ip1"
route_address_prefix22          = "***.**.*.*/32"

route_name23                    = "to-central-us-databricks-scc-replay-ip2"
route_address_prefix23          = "***.**.*.*/32"

route_name24                    = "Webapii1"
route_address_prefix24          = "***.**.*.*/32"

route_name25                    = "Webapp2"
route_address_prefix25          = "***.**.*.*/32"

# Azure Firewall details
az_firewall_name                = "control-plane-firewall"
az_conf_firwal_name             = "fw_publicip"
# Network rule collection details for test_databricks
az_net_rul_name                 = "databricks-control-plane-services"
az_net_rul_prio                 = 200
az_net_rul_act                  = "Allow"
az_rule_name                    = "databricks-webapp"
az_rule_dest_port               = 443
az_rule_protoc                  = "TCP"
az_rule_dest1_address           = "***.**.*.*/32"
az_rule_dest2_address           = "***.**.*.*9/32"

#Network rules details for others
az_rule_others_name                   = "others"
az_rule_other_dest1_address           = "***.**.*.*/32"
az_rule_other_dest2_address           = "***.**.*.*/32"
az_rule_other_dest3_address           = "***.**.*.*/28"

# Network Rules Details for  mysql 
az_rule_mysql_name                      = "mysql"
az_rule_mysql_dest1_address             ="***.**.*.*"
az_rule_mysql_dest2_address             ="***.**.*.*"
az_rule_mysql_dest3_address             ="***.**.*.*"
az_rule_mysql_dest4_address             ="***.**.*.*"
az_rule_mysql_dest_port                 = 3306

# Application rules details 
az_appl_rule_name                       = "databricks-control-plane-services"
az_appl_rule_databrick_spark_blob_stor  = "databricks-spark-log-blob-storage"
az_appl_rule_databricks_spa_target_fdq1 = "dblogprodwestus.blob.core.windows.net"
az_appl_rule_databricks_spa_target_fdq2 = "dblogprodcentralus.blob.core.windows.net"
az_appl_rule_port                       = 443
az_apple_rule_type                      = "Https"

az_appl_rule_databrick_artif_blob_stor  = "databricks-artifact-log-blob-storage"
az_appl_rule_databricks_arti_tar_fdq    = "dbartifactsprodcentralus.blob.core.windows.net"
az_appl_rule_databricks_arti_tar_fdq1   = "arprodcusa1.blob.core.windows.net"
az_appl_rule_databricks_arti_tar_fdq2   = "arprodcusa2.blob.core.windows.net"
az_appl_rule_databricks_arti_tar_fdq3   = "arprodcusa3.blob.core.windows.net"
az_appl_rule_databricks_arti_tar_fdq4   = "arprodcusa4.blob.core.windows.net"
az_appl_rule_databricks_arti_tar_fdq5   = "arprodcusa5.blob.core.windows.net"
az_appl_rule_databricks_arti_tar_fdq6   = "arprodcusa6.blob.core.windows.net"
az_appl_rule_databricks_arti_tar_fdq7   = "dbartifactsprodcus.blob.core.windows.net"
az_appl_rule_databricks_arti_tar_fdq8   = "dbartifactsprodscus.blob.core.windows.net"

az_appl_rule_dtb_dbfs                   = "databricks-dbfs"
az_appl_rule_dtb_dbfs_tar_fdq           = "dbstoragey3vxe6shnr5li.blob.core.windows.net"

az_appl_rule_evthub_endp                = "EventHubendpoint"
az_appl_rule_evhub_endp_tar_fdq         = "prod-westus-observabilityEventHubs.servicebus.windows.net"
az_appl_rule_evhub_endp_tar_fdq1        = "prod-centralusc2-observabilityeventhubs.servicebus.windows.net"

az_appl_rule_pyrepo                     = "PythosRepos"
az_appl_rule_pyrepo_tar_fdq             = "*pypi.org"
az_appl_rule_pyrepo_tar_fdq1            = "*pythonhosted.org"
az_appl_rule_pyrepo_tar_fdq2            = "cran.r-project.org"

az_appl_rule_gang                       = "GangilaUI"
az_appl_rule_gang_tar_fdq               = "cdnjs.com"
az_appl_rule_gang_tar_fdq1              = "cdnjs.cloudflare.com"

az_appl_rule_metasto                    = "metastore"
az_appl_rule_metasto_tar_fdq            = "consolidated-centralus-prod-metastore.mysql.database.azure.com"
az_appl_rule_metasto_tar_fdq1           = "consolidated-centralus-prod-metastore-addl-1.mysql.database.azure.com"
az_appl_rule_metasto_tar_fdq2           = "consolidated-centralusc2-prod-metastore-0.mysql.database.azure.com"

az_appl_rule_other                      = "other"
az_appl_rule_other_tar_fdq              = "*.blob.core.windows.net"

#Azure private endpoint details
az_pr_endpnt_name                       = "mdptest_endpoint_hub"
az_pr_service_name                      = "mdptesteventhub"


az_pr_endp_stor_name                    = "mdptest_endpoint_storage"
az_pr_service_stor_name                 = "mdpteststorage"

# Azure private dns zone details

az_private_dns_name                     = "privatelink.blob.core.windows.net"
az_private_dns_record_name              = "mdpdataplatformdatalake"
az_private_dns_records                  = "***.**.*.*"
az_private_dns_ttl                      = 3600
az_private_dns_record_name1             = "mdpdeltalake"
az_private_dns_records1                 = "***.**.*.*"


az_private_dns_name1                     = "privatelink.servicebus.windows.net"
az_private_dns_record_name2              = "mdpdatastream"
az_private_dns_ttl1                      = 10




