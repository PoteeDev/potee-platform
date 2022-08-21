terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = ""
  cloud_id  = ""
  folder_id = ""
  zone      = "ru-central1-a"
}
module "network" {
  source = "./modules/network"
}
module "firewall" {
  source        = "./modules/firewall"
  network_id    = module.network.id
  allowed_cidrs = [var.admin_subnet]
}
module "admin-node" {
  source      = "./modules/admin"
  name        = "admin"
  username    = var.admin_username
  ssh_key     = "${var.ssh_key_private}.pub"
  network_id  = module.network.id
  cidr_blocks = [var.admin_subnet]
  ip_address  = var.admin_ip
}

module "entity" {
  for_each = {
    for index, vm in var.entities : vm.name => vm
  }
  source         = "./modules/entity"
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
  provisioner "remote-exec" {
    inline = ["ip a"]
    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = file(var.ssh_key_private)
      host        = module.admin-node.external_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u ubuntu -i ${module.admin-node.external_ip}, --ssh-extra-args='-o ControlMaster=auto -o ControlPersist=60s -o StrictHostKeyChecking=no' --private-key ${var.ssh_key_private} ../../ansible/admin.yml"
  }
}

resource "null_resource" "entities" {
  provisioner "remote-exec" {
    inline = ["ip a"]
    connection {
      type        = "ssh"
      user        = var.admin_username
      private_key = file(var.ssh_key_private)
      host        = module.admin-node.external_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -f ${length(module.entity)} -u ubuntu -i ${join(",", [for index, vm in module.entity : vm.internal_ip])}, --ssh-extra-args='-o ControlMaster=auto -o ControlPersist=60s -o StrictHostKeyChecking=no -o ProxyCommand=\"ssh -o StrictHostKeyChecking=no -i ${var.ssh_key_private} -W %h:%p ubuntu@${module.admin-node.external_ip}\"' --private-key ${var.ssh_key_private} ../../ansible/entities.yml"
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
