resource "aws_security_group" "ecs" {
  name        = "${var.stack_prefix}-sg-ecs-${var.ecs.container_name}"
  description = "for ECS (${var.ecs.container_name})"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.ecs.host_port
    to_port     = var.ecs.host_port
    protocol    = "tcp"
    cidr_blocks = [for nw in var.elb_subnets : nw.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.stack_prefix}-sg-ecs-${var.ecs.container_name}" }
}

resource "aws_security_group" "elb" {
  name        = "${var.stack_prefix}-sg-elb-${var.ecs.container_name}"
  description = "for ELB (${var.ecs.container_name})"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.stack_prefix}-sg-elb-${var.ecs.container_name}" }
}