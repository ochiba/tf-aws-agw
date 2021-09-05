resource "aws_api_gateway_vpc_link" "ecs" {
  name        = "vpc_link"
  target_arns = [ aws_lb.ecs.arn ]

  tags = { Name = "${var.stack_prefix}-agw-vl-ecs-${var.ecs.container_name}" }
}

resource "aws_api_gateway_rest_api" "ecs" {
  name = local.agw_vars.name
  body = templatefile(
    "files/openapi/default.yml.tpl",
    local.agw_vars
  )

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = { Name = "${var.stack_prefix}-agw-ecs-${var.ecs.container_name}" }
  lifecycle {
    ignore_changes = [
      body
    ]
  }
}

resource "aws_api_gateway_deployment" "ecs" {
  rest_api_id = aws_api_gateway_rest_api.ecs.id
  stage_name  = "test"

  triggers = {
    redeployment = "v0.1"
  }

  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    aws_api_gateway_rest_api.ecs
  ]
}

resource "aws_api_gateway_rest_api_policy" "ecs" {
  rest_api_id = aws_api_gateway_rest_api.ecs.id
  policy      = data.aws_iam_policy_document.agw_ecs.json
}

data "aws_iam_policy_document" "agw_ecs" {
  statement {
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = [ "*" ]
    }
    actions   = [ "execute-api:Invoke" ]
    resources = [ "${aws_api_gateway_rest_api.ecs.execution_arn}/*" ]
    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = var.allow_src_ip
    }
  }
}