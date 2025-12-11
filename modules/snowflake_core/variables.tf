variable "team_acronym" { type = string }

variable "environments" {
  type = map(string)
  default = {
    dev = "dev"
    ppe = "ppe"
    prd = ""
  }
}

variable "snowflake_layers" { 
  type = map(any)
  default = {
    sources = { role_suffix = "sources_analyst" }
    product = { role_suffix = "product_analyst" } 
  }
}

variable "github_repo_name" { type = string } # Dependency input
