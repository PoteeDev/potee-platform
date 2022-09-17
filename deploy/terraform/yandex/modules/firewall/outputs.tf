output "admin_security_group" {
  value = yandex_vpc_security_group.admin_only.id
}