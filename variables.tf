variable "profiles" {
  default = {
    main = "satellite"
    prd  = "latte"
    sso  = "default"
  }
}

variable "system" {
  default = {
    id   = "com"
    name = "Common"
  }
}
variable "env" {
  default = {
    id   = "prd"
    name = "Production"
  }
}
variable "region" {
  default = {
    id   = "apne1"
    name = "ap-northeast-1"
  }
}