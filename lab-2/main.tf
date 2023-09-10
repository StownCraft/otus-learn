locals {
  vm_user           = "ec2-user"
  ssh_public_key    = "~/.ssh/id_rsa.pub"
  ssh_private_key   = "~/.ssh/id_rsa"
  vpc_name          = "test-vpc"
  subnet_cidrs      = ["172.31.0.0/16"]
  subnet_name       = "test-subnet"
}

resource "yandex_vpc_network" "vpc" {
  name              = local.vpc_name
}

resource "yandex_vpc_subnet" "subnet" {
  name              = local.subnet_name
  zone              = var.zone
  network_id        = yandex_vpc_network.vpc.id
  v4_cidr_blocks    = local.subnet_cidrs
}

module "create_LB" {
  source            = "./modules/create-vm"
  count             = 1
  vm_name           = "lb-${count.index + 1}"
  vpc_name          = local.vpc_name
  subnet_cidrs      = yandex_vpc_subnet.subnet.v4_cidr_blocks
  subnet_name       = yandex_vpc_subnet.subnet.name
  subnet_id         = yandex_vpc_subnet.subnet.id
  vm_user           = local.vm_user
  ssh_public_key    = local.ssh_public_key
  ssh_private_key   = local.ssh_private_key
  zone              = var.zone
}

module "create_BE" {
  source            = "./modules/create-vm"
  count             = 2
  vm_name           = "be-${count.index + 1}"
  vpc_name          = local.vpc_name
  subnet_cidrs      = yandex_vpc_subnet.subnet.v4_cidr_blocks
  subnet_name       = yandex_vpc_subnet.subnet.name
  subnet_id         = yandex_vpc_subnet.subnet.id
  vm_user           = local.vm_user
  ssh_public_key    = local.ssh_public_key
  ssh_private_key   = local.ssh_private_key
  zone              = var.zone
}

module "create_DB" {
  source            = "./modules/create-vm"
  count             = 1
  vm_name           = "db-${count.index + 1}"
  vpc_name          = local.vpc_name
  subnet_cidrs      = yandex_vpc_subnet.subnet.v4_cidr_blocks
  subnet_name       = yandex_vpc_subnet.subnet.name
  subnet_id         = yandex_vpc_subnet.subnet.id
  vm_user           = local.vm_user
  ssh_public_key    = local.ssh_public_key
  ssh_private_key   = local.ssh_private_key
  zone              = var.zone
}

resource "local_file" "inventory_file" {
  content = templatefile("./templates/inventory.tftpl",
    {
      loadbalancers = module.create_LB
      backends      = module.create_BE
      databases     = module.create_DB
    }
  )
  filename          = "./ansible/hosts"
}

resource "local_file" "internal_ips_file" {
  content = templatefile("./templates/internal_ips.tftpl",
    {
      backends      = module.create_BE
      databases     = module.create_DB
    }
  )
  filename          = "./ansible/group_vars/all/internal_ips.yml"
}

//provisioner "local-exec" {
//  command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u '${local.vm_user}' -i './ansible/hosts' --private-key '${local.ssh_private_key}' ./ansible/main.yml"
//}
