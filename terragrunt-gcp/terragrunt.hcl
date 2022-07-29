locals {
   project = "still-toolbox-356811"
   subnet_region_1 = "us-central1"
   subnet_region_2 = "us-east1"
}


generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
  provider "google" {
  project = "still-toolbox-356811"
  region  = "us-central1"
  }
EOF
}

generate "backend" {
  path = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  backend "gcs" {
    bucket  = "still-toolbox-356811-terraform-tfstates"
    prefix  = "${path_relative_to_include()}/terraform.tfstate"
  }
}
EOF
}


