data "aws_iam_policy" "view_only_access" {
  name = "ViewOnlyAccess"
}

data "aws_iam_policy" "administrator_access" {
  name = "AdministratorAccess"
}

data "aws_iam_policy" "codepipeline_full_access" {
  name = "AWSCodePipelineFullAccess"
}

resource "aws_iam_role" "my_admin" {
  name               = "${var.stack_prefix}-AdminRole"
  assume_role_policy = data.aws_iam_policy_document.my_switch_assume_role.json
  managed_policy_arns = [
    data.aws_iam_policy.administrator_access.arn
  ]
}

resource "aws_iam_role" "my_switch" {
  name               = "${var.stack_prefix}-SwitchRole"
  assume_role_policy = data.aws_iam_policy_document.my_switch_assume_role.json
  managed_policy_arns = [
    aws_iam_policy.my_switch_role.arn
  ]
}

data "aws_iam_policy_document" "my_switch_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.sso_account_id}:root"]
    }
    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"

      values = var.allow_src_ip
    }
  }
}

resource "aws_iam_policy" "my_switch_role" {
  name   = "${var.stack_prefix}-SwitchRole"
  policy = data.aws_iam_policy_document.my_switch_role.json
}

data "aws_iam_policy_document" "my_switch_role" {
  statement {
    sid       = "S3ListAllMyBuckets"
    effect    = "Allow"
    actions   = [ "s3:ListAllMyBuckets" ]
    resources = [ "*" ]
  }
  statement {
    sid       = "PassRole"
    effect    = "Allow"
    actions   = [ "iam:PassRole" ]
    resources = [
      "arn:aws:iam::${var.main_account_id}:role/${var.stack_prefix}-*"
    ]
  }
  statement {
    sid       = "APIGatewayAdministrator"
    effect    = "Allow"
    actions   = [ "apigateway:*" ]
    resources = [
      "arn:aws:apigateway:*::/*"
    ]
  }
  statement {
    sid       = "CodeBrothersDeveloper"
    effect    = "Allow"
    actions   = [
      "codepipeline:*",
      "codestar-connections:*"
    ]
    resources = [
      "arn:aws:codepipeline:*:${var.main_account_id}:*",
      "arn:aws:codestar-connections:*:${var.main_account_id}:*",
    ]
  }
}