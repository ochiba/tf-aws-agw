# Main Profile
provider "aws" {
  profile = var.profiles.main
  region  = var.region.name

  default_tags {
    tags = local.tags
  }
}

data "aws_caller_identity" "main" {}

# Production Profile
provider "aws" {
  alias = "prd"

  profile = var.profiles.prd
  region  = var.region.name

  default_tags {
    tags = local.tags
  }
}

data "aws_caller_identity" "prd" {
  provider = aws.prd
}

# SSO Profile
provider "aws" {
  alias = "sso"

  profile = var.profiles.sso
  region  = var.region.name

  default_tags {
    tags = local.tags
  }
}

data "aws_caller_identity" "sso" {
  provider = aws.sso
}