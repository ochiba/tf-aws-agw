data "aws_acm_certificate" "issued" {
  domain   = "*.${var.ecs.domain}"
  statuses = [ "ISSUED" ]
}

resource "aws_lb" "ecs" {
  name               = "${var.stack_prefix}-elb-${var.ecs.container_name}"
  internal           = true
  load_balancer_type = "network"
  subnets            = [ for nw in var.elb_subnets : nw.id ]

  tags = { Name = "${var.stack_prefix}-elb-${var.ecs.container_name}" }
}

resource "aws_lb_listener" "ecs" {
  load_balancer_arn = aws_lb.ecs.arn

  port            = 443
  protocol        = "TLS"
  certificate_arn = data.aws_acm_certificate.issued.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs.arn
  }
}

resource "aws_lb_target_group" "ecs" {
  name   = "${var.stack_prefix}-tg-${var.ecs.container_name}"
  vpc_id = var.vpc_id

  port        = var.ecs.host_port
  protocol    = "TCP"
  target_type = "ip"

  health_check {
    port = var.ecs.host_port
    path = var.ecs.health_check_path
  }

  deregistration_delay = 60
}