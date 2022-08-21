variable network_id {
    type = string
}

variable "ssh_key" {
  type = string
  default = "./id_rsa.pub"
}

variable "name" {
  type = string
  default = "admin"
}

variable "username" {
  type = string
  default = "ubuntu"
}

variable "cidr_blocks" {
  type = list(string)
}

variable "ip_address" {
  type = string
}
