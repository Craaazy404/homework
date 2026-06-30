locals {
  vm_names = {
    web = var.vm_web_name
    db  = var.vm_db_name
  }

  metadata = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }
}
