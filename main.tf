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
  source             = "./terraform/yandex/modules/admin"
  name               = "admin"
  username           = var.admin_username
  ssh_key            = "${var.ssh_key_private}.pub"
  dns_public_zone_id = module.network.dns_public_zone_id
  public_domain      = var.public_domain
  domains            = ["vpn", "api", "minio", "traefik"]
  network_id         = module.network.id
  cidr_blocks        = [var.admin_subnet]
  ip_address         = var.admin_ip
}

module "entity" {
  for_each = {
    for index, vm in var.entities : vm.name => vm
  }
  source         = "./terraform/yandex/modules/entity"
  network_id     = module.network.id
  dns_zone       = module.network.dns_zone_id
  name           = each.value.name
  ssh_key        = "${var.ssh_key_private}.pub"
  subnet_name    = "${each.value.name}-subnet"
  cidr_blocks    = [each.value.cidr]
  services       = each.value.services
  nat_route      = module.network.nat_route_id
  security_group = [module.firewall.admin_security_group]
}

resource "null_resource" "admin" {
  provisioner "local-exec" {
    command = "ansible-playbook -u ubuntu -i ${module.admin-node.external_ip}, --ssh-extra-args='-o ControlMaster=auto -o ControlPersist=60s -o StrictHostKeyChecking=no' --private-key ${var.ssh_key_private} ansible/admin.yml"
  }
}

resource "null_resource" "entities" {
  provisioner "local-exec" {
    command = "ansible-playbook -f ${length(module.entity)} -u ubuntu -i ${join(",", [for index, vm in module.entity : vm.internal_ip])}, --ssh-extra-args='-o ControlMaster=auto -o ControlPersist=60s -o StrictHostKeyChecking=no -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i ${var.ssh_key_private} -W %h:%p ubuntu@${module.admin-node.external_ip}\"' --private-key ${var.ssh_key_private} ansible/entities.yml"
  }
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
