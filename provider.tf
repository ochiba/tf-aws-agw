# Main Profile
provider "aws" {
  profile = var.profiles.main
  region  = var.region.name

  default_tags {
    tags = local.tags
  }
}

data "aws_caller_identity" "main" {}

provider "aws" {
  alias = "sso"

  profile = var.profiles.sso
  region  = var.region.name
}

data "aws_caller_identity" "sso" {
  provider = aws.sso
}