locals {
  ecs_vars = {
    cluster_name       = "${var.stack_prefix}-${var.ecs.container_name}-cluster"
    service_name       = "${var.stack_prefix}-${var.ecs.container_name}-service"
    task_name          = "${var.stack_prefix}-${var.ecs.container_name}-task"
    container_name     = "${var.stack_prefix}-${var.ecs.container_name}"
    image_location     = "nginx:latest"
    cpu                = var.ecs.cpu
    memory             = var.ecs.memory
    memory_reservation = var.ecs.memory_reservation
    container_port     = var.ecs.container_port
    host_port          = var.ecs.host_port
    log_group          = "/usr/${var.stack_prefix}/ecs"
    log_region         = var.region.name
    log_prefix         = var.ecs.container_name
  }
  agw_vars = {
    name        = "${var.stack_prefix}-agw-ecs-${var.ecs.container_name}"
    nlb_uri     = "https://${aws_route53_record.org.name}"
    vpc_link_id = aws_api_gateway_vpc_link.ecs.id
  }
}