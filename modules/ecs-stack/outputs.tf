output "elb" {
  value = {
    arn    = aws_lb.ecs.arn
    id     = aws_lb.ecs.dns_name
    domain = aws_route53_record.org.name
  }
}
output "agw" {
  value = {
    arn           = aws_api_gateway_rest_api.ecs.arn
    execution_arn = aws_api_gateway_rest_api.ecs.execution_arn
  }
}