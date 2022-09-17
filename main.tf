resource "local_file" "ansible_inventory" {
  content = templatefile("deploy/ansible/inventory.tmpl",
    {
      entities = {
        nakateam = {
          internal_ip = "10.0.2.10"
        }
        naliway = {
          internal_ip = "10.0.1.10"
        }
      }
      admin_ip = "12.24.124.23"
    }
  )
  filename = "inventory"
}
