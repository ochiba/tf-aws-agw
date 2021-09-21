variable "stack_prefix" { type = string }
variable "region" { type = map(any) }

variable "vpc" {
  default = {
    id   = "vpc-0cbf227af30e39346"
    cidr = "192.168.0.0/16"
  }
}
variable "subnets" {
  default = {
    public = [
      { az = "a", cidr = "192.168.0.0/22" },
      { az = "c", cidr = "192.168.4.0/22" }
    ]
    private = [
      { az = "a", cidr = "192.168.16.0/22" },
      { az = "c", cidr = "192.168.20.0/22" }
    ]
  }
}
variable "nat_gateway_num" {
  default = 0
}