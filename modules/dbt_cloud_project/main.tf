# [cite_start]Create the DBT Project [cite: 119]
resource "dbt_cloud_project" "team_project" {
  [cite_start]name = var.team_acronym # Pattern: [team] [cite: 117]
}

# Configure Environments and Deployment Connection
resource "dbt_cloud_environment" "team_env" {
  for_each  = var.sf_connections_map # Iterates over dev, ppe, prd
  project_id = dbt_cloud_project.team_project.id
  name       = each.key # e.g., "dev"
  dbt_version = "1.7.0" 

  # Configure the deployment connection using the Snowflake outputs from Module B
  credential_id = dbt_cloud_credential.team_credential[each.key].credential_id
}

# Create or Link Service Account (assuming dbt provider manages this)
resource "dbt_cloud_service_account" "team_service_account" {
  for_each  = var.sf_connections_map
  [cite_start]name      = "SVC_${upper(each.key)}_${upper(var.team_acronym)}_DEV_SFACC" # Example pattern based on [cite: 117]
  # ... Configuration details ...
}
