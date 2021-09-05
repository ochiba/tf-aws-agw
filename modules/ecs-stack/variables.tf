variable "stack_prefix" { type = string }
variable "region" { type = map(any) }

variable "ecs" { type = map(any) }
variable "execution_role_arn" { type = string }
variable "task_role_arn" { type = string }

variable "vpc_id" { type = string }
variable "elb_subnets" { type = list(any) }
variable "ecs_subnets" { type = list(any) }