terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}
resource "yandex_vpc_network" "network" {
  name = var.network_name
}

resource "yandex_dns_zone" "potee" {
  name        = "potee-private-zone"
  description = "desc"

  zone             = "${var.domain}."
  public           = false
  private_networks = [yandex_vpc_network.network.id]
}

resource "yandex_compute_instance" "nat" {
  name = "nat"
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd8q9r5va9p64uhch83k"
    }
  }
  network_interface {
    subnet_id  = yandex_vpc_subnet.public-subnet.id
    ip_address = var.nat_gateway
    nat        = true
  }

}

resource "yandex_vpc_subnet" "public-subnet" {
  name           = "nat-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [var.nat_cidr]
}

resource "yandex_vpc_route_table" "nat-route" {
  network_id = yandex_vpc_network.network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat_gateway
  }
}
