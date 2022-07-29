locals {
    environment_config = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
    environment = local.environment_config.locals.environment
    common_config = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
    project = local.common_config.locals.project
    subnet_region_first = local.common_config.locals.subnet_region_1
    subnet_region_second = local.common_config.locals.subnet_region_2
}

terraform {
  source = "tfr:///terraform-google-modules/network/google?version=5.1.0"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
    project_id   = "${local.project}"
    network_name = "${local.environment}-vpc"
    subnets = [
        {
            subnet_name           = "${local.environment}-subnet-01"
            subnet_ip             = "10.0.3.0/24"
            subnet_region         = "${local.subnet_region_first}"
        },
        {
            subnet_name           = "${local.environment}-subnet-02"
            subnet_ip             = "10.0.4.0/24"
            subnet_region         = "${local.subnet_region_second}"
            subnet_private_access = "true"
        }
    ]
}