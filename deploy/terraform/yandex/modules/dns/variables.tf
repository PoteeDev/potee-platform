variable "public_domain" {
  type = string
  default = "potee.ru"
}

variable "public_ip" {
  type = string
}

variable "api_token" {
  type        = string
  description = "cloudflare api token"
}