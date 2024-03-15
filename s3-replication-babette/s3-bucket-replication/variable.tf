variable "aws_region_main" {
  type        = string
  description = "The AWS region"
  default     = "us-east-1"
}

variable "aws_region_backup" {
  type        = string
  description = "The AWS region"
  default     = "us-east-2"
}


variable "common_tags" {
  type = map(any)
  default = {
    "id"             = "2127"
    "owner"          = "Jones"
    "teams"          = "Shushu's Bridal Boutique"
    "environment"    = "dev"
    "project"        = "s3-bucket"
    "create_by"      = "Shushu -Terraform"
    "cloud_provider" = "aws"
  }
}
