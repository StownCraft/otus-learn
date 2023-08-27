variable "zone" {
  type = string
  default = "ru-central1-a"
  description = "zone"
}

variable "image_id" {
  description = "Default image ID Ubuntu 22.04 LTS"
  default     = "fd8fco5lpqbhanbfg2du" # ubuntu-2204-lts
  type        = string
}

variable "cpu" {
  description = "VM CPU count"
  default     = 2
  type        = number
}

variable "memory" {
  description = "VM RAM size"
  default     = 4
  type        = number
}

variable "core_fraction" {
  description = "Core fraction, default 20%"
  default     = 20
  type        = number
}

variable "disk" {
  description = "VM Disk size"
  default     = 20
  type        = number
}

variable "nat" {
  type    = bool
  default = true
}

variable "internal_ip_address" {
  type    = string
  default = null
}

variable "nat_ip_address" {
  type    = string
  default = null
}

variable "disk_type" {
  description = "Disk type"
  type        = string
  default     = "network-ssd"
}