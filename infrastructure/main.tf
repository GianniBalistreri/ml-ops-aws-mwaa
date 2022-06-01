# Terraform config:
terraform {
  backend "s3" {
    bucket = "gfb-ml-ops-tf-infrastructure"
    key    = "airflow-mwaa/tf-state"
    region = "eu-central-1"
  }
}
