terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  cloud_id  = "b1gg7nkcb9s8f8r3jepq"
  folder_id = "b1gr97ej8jl9c90meu3f"
}