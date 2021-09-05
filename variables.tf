variable "profiles" {
  default = {
    main = "satellite"
    sso  = "sso"
  }
}

variable "system" {
  default = {
    id   = "ocb"
    name = "Ochiba"
  }
}
variable "env" {
  default = {
    id   = "dev"
    name = "Develop"
  }
}
variable "region" {
  default = {
    id   = "apne1"
    name = "ap-northeast-1"
  }
}

variable "allow_src_ip" {
  default = [
    "60.125.192.191"
  ]
}

variable "ecs_web" {
  default = {
    domain             = "poc1.ochiba.work"
    container_name     = "web"
    cpu                = 256
    memory             = 512
    memory_reservation = 128
    container_port     = 80
    host_port          = 80
    desired_count      = 1
    platform_version   = "1.4.0"
    health_check_path  = "/"
  }
}