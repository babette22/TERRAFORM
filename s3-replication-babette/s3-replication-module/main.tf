## Terraform block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  alias  = "main-bucket"
  region = local.aws_region_main
}

provider "aws" {
  alias  = "backup-bucket"
  region = local.aws_region_backup
}

locals {
  aws_region_main   = "us-east-1"
  aws_region_backup = "us-east-2"

  common_tags = {

    "id"             = "2127"
    "owner"          = "Jones"
    "teams"          = "Shushu's Bridal Boutique"
    "environment"    = "dev"
    "project"        = "s3-bucket"
    "create_by"      = "Shushu -Terraform"
    "cloud_provider" = "aws"
  }
}

module "s3-backup-replication-module" {
  source      = "github.com/DEL-ORG/a1jones_projects.git//s3-bucket-replication?ref=main"
  common_tags = local.common_tags

}