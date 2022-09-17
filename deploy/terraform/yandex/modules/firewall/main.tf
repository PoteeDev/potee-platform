terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_vpc_security_group" "admin_only" {
  name        = "My security group"
  description = "description for my security group"
  network_id  = var.network_id


  ingress {
    protocol       = "ANY"
    description    = "Allow trafik from admin node"
    v4_cidr_blocks = var.allowed_cidrs
    from_port      = 1
    to_port        = 65535
  }
  egress {
    protocol       = "ANY"
    description    = "Allow trafik to admin node"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 1
    to_port        = 65535
  }
}
