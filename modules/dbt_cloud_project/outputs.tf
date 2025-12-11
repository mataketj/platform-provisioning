output "dbt_project_id" {
  description = "The ID of the provisioned DBT Cloud project."
  value       = dbt_cloud_project.team_project.id
}
