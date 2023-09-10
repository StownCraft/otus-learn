resource "yandex_compute_instance" "instances" {
  name              = var.vm_name
  hostname          = var.vm_name
  platform_id       = var.platform_id
  zone              = var.zone
  resources {
    cores           = var.cpu
    memory          = var.memory
    core_fraction   = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id      = var.image_id
      size          = var.disk
      type          = var.disk_type
    }
  }

  network_interface {
    subnet_id       = var.subnet_id
    nat             = var.nat
    ip_address      = var.internal_ip_address
    nat_ip_address  = var.nat_ip_address
  }

  metadata = {
    user-data       = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file(var.ssh_public_key)}"
  }

  connection {
    type        = "ssh"
    user        = var.vm_user
    private_key = file(var.ssh_private_key)
    host        = self.network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    inline = ["echo 'it works'"]
  }
}