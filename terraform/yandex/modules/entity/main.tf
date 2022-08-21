terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_compute_instance" "vm" {
  name = var.name

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = "fd8ju9iqf6g5bcq77jns"
    }
  }

  dynamic "network_interface" {
    for_each = var.services.*.ip
    content {
      subnet_id  = yandex_vpc_subnet.entity-subnet.id
      ip_address = network_interface.value
      security_group_ids = var.security_group
    }
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.ssh_key)}"
  }
}

resource "yandex_vpc_subnet" "entity-subnet" {
  name           = var.subnet_name
  zone           = "ru-central1-a"
  network_id     = var.network_id
  v4_cidr_blocks = var.cidr_blocks
  route_table_id = var.nat_route
}

resource "yandex_dns_recordset" "rs" {
  for_each = {
    for index, srv in var.services : srv.name => srv
  }
  zone_id = var.dns_zone
  name    = "${each.value.name}.${var.name}.${var.domain}."
  type    = "A"
  ttl     = 200
  data    = [each.value.ip]
}
