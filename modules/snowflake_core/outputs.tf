output "snowflake_dbt_connections" {
  description = "Map of connections for DBT Cloud (Role, Warehouse, DB)."
  value = {
    for env, prefix in var.environments :
    env => {
      # Example output for Dev environment linkage in DBT Cloud
      role      = snowflake_role.team_roles["sources_${env}_developer"].name 
      warehouse = snowflake_warehouse.team_whs["sources_${env}"].name 
      database  = snowflake_database.team_dbs["sources_${env}"].name
    }
  }
}

output "snowflake_role_list" {
  description = "List of all provisioned role names."
  value       = [for role in snowflake_role.team_roles : role.name]
}
