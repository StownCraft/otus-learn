locals {
  user            = "ec2-user"
  ssh_public_key  = "~/.ssh/id_rsa.pub"
  ssh_private_key = "~/.ssh/id_rsa"
}

resource "yandex_vpc_network" "test-vpc" {
  name = "test-vpc"
}

resource "yandex_vpc_subnet" "test-subnet" {
  name           = "test-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.test-vpc.id
  v4_cidr_blocks = ["172.31.0.0/16"]
}

resource "yandex_compute_instance" "vm-1" {
  name = "otus-terraform-lab"
  hostname = "otus-terraform-lab.loc"
  zone = var.zone

  resources {
    cores  = var.cpu
    memory = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size = var.disk
      type = var.disk_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.test-subnet.id
    nat       = true
    ip_address         = var.internal_ip_address
    nat_ip_address     = var.nat_ip_address
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${local.user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file(local.ssh_public_key)}"
  }

  connection {
    type        = "ssh"
    user        = local.user
    private_key = file(local.ssh_private_key)
    host        = self.network_interface.0.nat_ip_address
  }

  provisioner "remote-exec" {
    inline = ["echo 'it works'"]
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u '${local.user}' -i '${self.network_interface.0.nat_ip_address},' --private-key '${local.ssh_private_key}' install_nginx.yml"
  }
}