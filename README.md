# Platform Provisioning (SANLAKE Onboarding)

This repository contains the Infrastructure as Code (IaC) boilerplate for onboarding new teams to the SANLAKE platform. It utilizes Terraform modules and GitHub Actions to automate the provisioning of resources across GitHub, Snowflake, and dbt Cloud.

## 🚀 Overview

The codebase is structured to enforce naming conventions and standard configurations for the "SANLAKE" data platform.

### Architecture

The automation consists of four sequential stages (Modules):

1.  **Module A (GitHub)**: Creates a private team repository matching the standard naming convention.
2.  **Module B (Snowflake Core)**: Provisions Databases, Warehouses, and Roles for `dev`, `ppe`, and `prd` environments.
3.  **Module C (dbt Cloud)**: Creates a dbt Cloud project, links it to the GitHub repo, and configures connections to Snowflake.
4.  **Module D (Snowflake Views)**: Executes post-deployment SQL to create necessary source views and grants.

## 📂 Project Structure

```
.
├── .github/workflows/       # Automation pipelines
│   └── provision_sanlake_team.yml
├── environments/            # Environment configurations
│   └── onboarding/
│       └── team_scbi.tfvars # Example team configuration
└── modules/                 # Terraform Modules
    ├── github_repo/         # Module A
    ├── snowflake_core/      # Module B
    ├── dbt_cloud_project/   # Module C
    └── snowflake_views/     # Module D
```

Each module follows a standard structure containing `main.tf`, `variables.tf`, `providers.tf`, `outputs.tf`, and `terraform.tfvars`.

## 🛠 Prerequisites

To run this automation successfully, the following prerequisites must be met:

### GitHub Secrets

The GitHub Actions workflow requires the following secrets to be configured in your repository settings:

*   `SNOWFLAKE_USER`: Service account user with sufficient privileges (ACCOUNTADMIN or delegated generic role).
*   `SNOWFLAKE_PASSWORD`: Password for the Snowflake service account.
*   `DBT_CLOUD_API_KEY`: Admin API Token for dbt Cloud.
*   `GITHUB_TOKEN`: (Automatically provided by Actions) Needs permission to create repositories.

### Local Development Tools (Optional)

If running Terraform locally:

*   [Terraform](https://www.terraform.io/) (v1.5+)
*   [SnowSQL](https://docs.snowflake.com/en/user-guide/snowsql-install-config) (for Module D views)
*   `jq` (for processing JSON outputs)

## 🏃 How to Run

### Automated Execution (Recommended)

1.  Navigate to the **Actions** tab in this repository.
2.  Select the **SANLAKE Team Onboarding: Automated Provisioning** workflow.
3.  Click **Run workflow**.
4.  Fill in the required inputs:
    *   **Team Alias**: e.g., `sanlam_corporate_bi`
    *   **Team Acronym**: e.g., `scbi`
    *   **Tfvars File**: Path to the variable file (default: `environments/onboarding/team_scbi.tfvars`)

### Local Execution (Debugging)

To run a specific module locally:

1.  Navigate to the module directory (e.g., `cd modules/snowflake_core`).
2.  Initialize Terraform: `terraform init`.
3.  Run Plan/Apply using the `.tfvars` from the root (adjust paths as needed):
    ```bash
    terraform apply -var-file="../../environments/onboarding/team_scbi.tfvars" \
      -var "github_repo_name=slm-sanlake/dbtlabs-scbi"
    ```
    *(Note: You will need to manually provide values for inputs that are normally passed as dependencies from previous steps).*
