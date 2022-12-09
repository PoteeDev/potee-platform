output "id" {
  value = yandex_vpc_network.network.id
}
output "dns_zone_id" {
  value = yandex_dns_zone.potee.id
}
# output "dns_public_zone_id" {
#   value = yandex_dns_zone.public_potee.id
# }
output "nat_route_id" {
  value = yandex_vpc_route_table.nat-route.id
}
