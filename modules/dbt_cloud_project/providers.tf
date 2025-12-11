terraform {
  required_providers {
    dbt = {
      source  = "dbt-labs/dbtcloud"
      version = "~> 0.3"
    }
  }
}

provider "dbt" {
  # Authentication handled via DBT_CLOUD_ACCOUNT_ID, DBT_CLOUD_TOKEN env vars
}
