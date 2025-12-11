variable "team_acronym" { type = string }

variable "github_repo_name" { type = string }

variable "sf_connections_map" { 
  description = "Map of Snowflake connection details passed from Module B."
  type        = map(any)
}
