variable "network_id" {
  type = string
}

variable "name" {
  type = string
}

variable "username" {
  type    = string
  default = "ubuntu"
}
variable "ssh_key" {
  type    = string
  default = "./id_rsa.pub"
}

variable "cidr_blocks" {
  type = list(string)
}

variable "subnet_name" {
  type = string
}

variable "services" {
  type = list(object({
    ip   = string
    name = string
  }))
  default = [{
    name = "dev"
    ip   = "10.0.1.10"
  }]
}

variable "domain" {
  type    = string
  default = "space"
}

variable "admin_ip" {
  type    = string
  default = "192.168.0.10"
}

variable "security_group" {
  type = list(string)
}

variable "dns_zone" {
  type = string
}

variable "nat_route" {
  type = string
}
