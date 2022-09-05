variable "admin_username" {
  type    = string
  default = "ubuntu"
}
variable "ssh_key_private" {
  type    = string
  default = "./id_rsa"
}
variable "admin_ip" {
  type    = string
  default = "10.0.0.10"
}

variable "admin_subnet" {
  type    = string
  default = "10.0.0.0/24"
}

variable "public_domain" {
  type    = string
  default = "defence.potee.ru"
}

variable "services" {
  type = list(string)
}

variable "entities" {
  type = list(object({
    name = string
    cidr = string
    ip   = string
  }))
  default = [{
    name = "naliway"
    cidr = "10.0.1.0/24"
    ip   = "10.0.1.10"
    services = [
      "admin",
      "dev"
    ]
  }]
}
