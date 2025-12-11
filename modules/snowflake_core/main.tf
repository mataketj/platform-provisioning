# Use a data source or local variable to iterate over environments
locals {
  # Combines acronym and environment to create the base names
  # Example: "scbi_dev"
  env_acronyms = { for env_name, env_prefix in var.environments : 
    "${var.team_acronym}_${env_prefix}" => env_name
  }
}

# [cite_start]Provision Databases (e.g., scbi_sources_dev, scbi_product_dev) [cite: 108]
resource "snowflake_database" "team_dbs" {
  for_each = {
    for k in setproduct(keys(var.snowflake_layers), keys(var.environments)) : 
    "${k[0]}_${k[1]}" => { layer = k[0], env = k[1] }
  }
  
  # Pattern: [team]_[layer]_[env] 
  name = upper("${var.team_acronym}_${each.value.layer}_${var.environments[each.value.env]}")
}

# [cite_start]Provision Warehouses (e.g., scbi_sources_dev_wh) [cite: 108]
resource "snowflake_warehouse" "team_whs" {
  for_each = snowflake_database.team_dbs
  
  # Pattern: [team]_[layer]_[env]_wh 
  name = upper("${each.key}_WH")
  # ... resource monitor linkage ...
}

# [cite_start]Provision Roles (e.g., ar_dev_scbi_sources_analyst_sf) [cite: 104]
resource "snowflake_role" "team_roles" {
  for_each = {
    for k in setproduct(keys(var.snowflake_layers), keys(var.environments), ["analyst", "developer", "dbadmin"]) : 
    "${k[0]}_${k[1]}_${k[2]}" => { layer = k[0], env = k[1], role = k[2] }
  }
  
  env_prefix = var.environments[each.value.env] != "" ? "${var.environments[each.value.env]}_" : ""
  
  # [cite_start]Pattern: ar_[env]_[team]_[layer]_[role]_sf [cite: 104]
  name = "AR_${upper(self.env_prefix)}${upper(var.team_acronym)}_${upper(each.value.layer)}_${upper(each.value.role)}_SF"
  
  # ... Grants to databases/warehouses ...
}
