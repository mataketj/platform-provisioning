# [cite_start]Team Sanlake Alias (from contract) [cite: 99]
team_alias = "sanlam_corparate_bi"

# [cite_start]Standardized Acronym [cite: 99]
team_acronym = "scbi"

# Environment map for loops (dev, ppe, prd)
environments = {
  dev = "dev"
  ppe = "ppe"
  [cite_start]prd = "" # Production environment has no prefix [cite: 111]
}

# Assumed Manual Prerequisite Outputs (for linking/grants)
# These would typically be retrieved dynamically or from a secrets manager
manual_prereqs = {
  github_group_id = "SCBI_GH_GROUP_123"
  [cite_start]isim_role_dev   = "ArDevSCBIProductAnalystSF" # Example ISIM Role [cite: 281]
  [cite_start]dbt_group_dev   = "ug_dev_sgt_dbt_scbi_developer" # Example DBT Group [cite: 120]
  [cite_start]raw_schema_name = "raw_crm_customer" # Example RAW schema for view creation [cite: 150]
}

# Example of a Source/Product layer mapping (for module B)
snowflake_layers = {
  [cite_start]sources = { role_suffix = "sources_analyst" } # [cite: 108]
  product = { role_suffix = "product_analyst" } 
}
