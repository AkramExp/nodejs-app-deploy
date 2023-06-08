variable "civo_token" {}

terraform {
  required_providers {
    civo = {
      source = "civo/civo"
    }
  }
}

provider "civo" {
  token = var.civo_token
  region = "LON1"
}

data "civo_instances_size" "extra-small" {
    filter {
        key = "name"
        values = ["g3.xsmall"]
        match_by = "re"
    }

    filter {
        key = "type"
        values = ["instance"]
    }

}

data "civo_disk_image" "ubuntu" {
   filter {
        key = "name"
        values = ["ubuntu-jammy"]
   }
}

resource "civo_instance" "server" {
    hostname = "server"
    tags = ["python", "nginx"]
    notes = "this is a note for the server"
    size = element(data.civo_instances_size.extra-small.sizes, 0).name
    disk_image = element(data.civo_disk_image.ubuntu.diskimages, 0).id
}

output "server_ip" {
    value = civo_instance.server.public_ip
}