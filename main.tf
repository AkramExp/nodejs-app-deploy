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

data "civo_ssh_key" "ssh-key" {
  name = "ssh-key"
}

resource "civo_instance" "server" {
    hostname = "server"
    notes = "this is a note for the server"
    size = element(data.civo_instances_size.extra-small.sizes, 0).name
    disk_image = element(data.civo_disk_image.ubuntu.diskimages, 0).id
    sshkey_id = data.civo_ssh_key.ssh-key.id
}

output "server_ip" {
    value = civo_instance.server.public_ip
}