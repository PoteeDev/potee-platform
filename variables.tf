variable "admin_username" {
  type    = string
  default = "ubuntu"
}
variable "ssh_key_private" {
  type   = string
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

variable "entities" {
  type = list(object({
    name = string
    cidr = string
    services = list(object({
      name = string
      ip   = string
    }))
  }))
  default = [{
    name = "naliway"
    cidr = "10.0.1.0/24"
    services = [
      {
        name = "admin"
        ip   = "10.0.1.10"
      },
      {
        name = "dev"
        ip   = "10.0.1.11"
      }
    ]
  }]
}
