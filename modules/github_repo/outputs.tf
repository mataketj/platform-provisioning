output "repo_name" {
  description = "The full name of the provisioned GitHub repository."
  # Assuming the organization name 'slm-sanlake' is a constant or variable
  [cite_start]value       = "slm-sanlake/${github_repository.team_repo.name}" # Pattern: slm-sanlake/dbtlabs-scbi [cite: 130]
}
