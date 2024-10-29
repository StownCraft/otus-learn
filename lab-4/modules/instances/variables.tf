//variable "folder_id" {
//  type = string
//}

variable "vpc_name" {
  type = string
}

variable "zone" {
  type = string
  default = "ru-central1-b"
}

variable "network_interface" {
  type        = map(map(string))
  default     = {}
}

variable "vm_name" {
  type        = string
}

variable "cpu" {
  default     = 2
  type        = number
}

variable "memory" {
  default     = 2
  type        = number
}

variable "core_fraction" {
  default     = 100
  type        = number
}

variable "disk" {
  default     = 10
  type        = number
}

variable "disk_type" {
  type        = string
  default     = "network-ssd"
}
variable "secondary_disk" {
  type        = map(map(string))
  default     = {}
}
variable "allow_stopping_for_update" {
  type        = bool
  default     = true
}

variable "image_id" {
//  default     = "fd8gdak341ipk43gi96c"
  default     = "fd8qfp90a5l0m3d2htrm"
 // default = "fd837b0gcg6klm9d9nl6"
 // default = "fd84itfojin92kj38vmb"
  type        = string
}

variable "nat" {
  type    = bool
  default = true
}

variable "platform_id" {
  type    = string
  default = "standard-v3"
}

variable "internal_ip_address" {
  type    = string
  default = null
}

variable "nat_ip_address" {
  type    = string
  default = null
}

variable "vm_user" {
  type        = string
  default = ""
}

variable "ssh_public_key" {
  type        = string
  default = ""
}

variable "ssh_private_key" {
  type        = string
  default = ""
}