variable "profiles" {
  default = {
    main = "satellite"
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