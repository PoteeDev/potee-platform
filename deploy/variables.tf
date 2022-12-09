variable "admin_username" {
  type    = string
  default = "ubuntu"
}
variable "ssh_key_private" {
  type    = string
  default = "./keys/id_rsa"
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
  default = "potee.ru"
}

variable "cloudflare_api_token" {
  type        = string
  description = "cloudflare api token"
}

variable "services" {
  type = list(string)
}

variable "entities" {
  type = list(object({
    name = string
    cidr = string
    password = string
  }))
}
