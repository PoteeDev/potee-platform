terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  cloud_id  = "b1gecc3098b7di8fk9fm"
  folder_id = "b1ga705ubqi0n5okur4e"
  zone      = "ru-central1-a"
}
module "network" {
  source = "./terraform/yandex/modules/network"
}
module "firewall" {

  source        = "./terraform/yandex/modules/firewall"
  network_id    = module.network.id
  allowed_cidrs = [var.admin_subnet]
}
module "admin-node" {
  source      = "./terraform/yandex/modules/admin"
  name        = "admin"
  username    = var.admin_username
  ssh_key     = "${var.ssh_key_private}.pub"
  domains     = ["vpn", "api", "minio", "traefik"]
  network_id  = module.network.id
  cidr_blocks = [var.admin_subnet]
  ip_address  = var.admin_ip
}

module "entity" {
  for_each = {
    for index, vm in var.entities : vm.name => vm
  }
  source         = "./terraform/yandex/modules/entity"
  network_id     = module.network.id
  dns_zone       = module.network.dns_zone_id
  name           = each.value.name
  password       = each.value.password
  ssh_key        = "${var.ssh_key_private}.pub"
  subnet_name    = "${each.value.name}-subnet"
  cidr_blocks    = [each.value.cidr]
  ip_address     = cidrhost(each.value.cidr, 10)
  services       = var.services
  nat_route      = module.network.nat_route_id
  security_group = [module.firewall.admin_security_group]
}

module "dns" {
  source        = "./terraform/yandex/modules/dns"
  public_ip     = module.admin-node.external_ip
  public_domain = var.public_domain
  api_token     = var.cloudflare_api_token
}

resource "local_file" "ansible_inventory" {
  content = templatefile("ansible/inventory.tmpl",
    {
      entities = module.entity
      admin_ip = module.admin-node.external_ip
    }
  )
  filename = "ansible/inventory"
}

output "internal_ip_address_admin" {
  value = module.admin-node.internal_ip
}

output "external_ip_address_admin" {
  value = module.admin-node.external_ip
}

output "entities" {
  value = module.entity
}
