resource "github_repository" "team_repo" {
  name       = "dbtlabs-${var.team_acronym}"
  visibility = "private"
  # [cite_start]Standardized prefix enforced in the organization level repo structure [cite: 130]
  # Full name will be slm-sanlake/dbtlabs-scbi
}

# ... Additional resources for branch protection, etc. ...
