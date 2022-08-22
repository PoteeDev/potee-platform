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
    cores  = 4
    memory = 8
  }

  boot_disk {
    initialize_params {
      image_id = "fd8ju9iqf6g5bcq77jns"
      size = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.admin-subnet.id
    ip_address = var.ip_address
    nat       = true
  }

  metadata = {
    ssh-keys = "${var.username}:${file(var.ssh_key)}"
  }
}

resource "yandex_vpc_subnet" "admin-subnet" {
  name           = "admin-subnet"
  zone           = "ru-central1-a"
  network_id     = var.network_id
  v4_cidr_blocks = var.cidr_blocks
}

resource "yandex_dns_recordset" "rs" {
  for_each = toset(var.domains)
  zone_id = var.dns_public_zone_id
  name    = "${each.value}.${var.public_domain}."
  type    = "A"
  ttl     = 200
  data    = [yandex_compute_instance.vm.network_interface.0.nat_ip_address]
}
