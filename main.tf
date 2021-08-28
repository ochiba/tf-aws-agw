module "network" {
  source = "./modules/network"

  stack_prefix = local.stack_prefix
  region       = var.region

  vpc             = var.vpc
  subnets         = var.subnets
  nat_gateway_num = 1
}