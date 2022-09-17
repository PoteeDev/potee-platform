variable "network_name" {
  type    = string
  default = "potee-network"
}

variable "domain" {
  type    = string
  default = "space"
}
variable "public_domain" {
  type = string
  default = "potee.ru"
}

variable "nat_cidr" {
  type    = string
  default = "10.0.254.0/24"
}

variable "nat_gateway" {
  type    = string
  default = "10.0.254.10"
}
