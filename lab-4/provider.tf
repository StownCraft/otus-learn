terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  cloud_id  = "b1gj9hrj166sg00vir3b"
  folder_id = "b1gnr9t6pl3t73a8gh8e"
}

locals {
  cloud_id  = "b1gj9hrj166sg00vir3b"
  zone      = "ru-central1-b"
}