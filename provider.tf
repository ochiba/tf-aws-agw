# Main Profile
provider "aws" {
  profile = var.profiles.main
  region  = var.region.name

  default_tags {
    tags = local.tags
  }
}

data "aws_caller_identity" "main" {}