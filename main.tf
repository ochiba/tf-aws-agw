module "network" {
  source = "./modules/network"

  stack_prefix = local.stack_prefix
  region       = var.region

  nat_gateway_num = 1
}

module "iam" {
  source = "./modules/iam"

  stack_prefix = local.stack_prefix

  main_account_id = data.aws_caller_identity.main.account_id
  sso_account_id  = data.aws_caller_identity.sso.account_id
  allow_src_ip    = var.allow_src_ip
}

module "ecs_web" {
  source = "./modules/ecs-stack"

  stack_prefix = local.stack_prefix
  region       = var.region

  allow_src_ip       = var.allow_src_ip
  ecs                = var.ecs_web
  execution_role_arn = module.iam.roles.ecs_service.arn
  task_role_arn      = module.iam.roles.ecs_task.arn
  vpc_id             = module.network.vpc.id
  elb_subnets        = module.network.subnets.private
  ecs_subnets        = module.network.subnets.private
}