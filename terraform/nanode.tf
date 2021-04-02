terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
  }
}

provider "linode" {
  token = var.LINODE_TOKEN
}

data "linode_profile" "me" {}

resource "linode_instance" "playbox" {
  label            = "box-1"
  image            = "linode/ubuntu20.04"
  type             = "g6-nanode-1"
  region           = "eu-west"
  tags             = ["terraform", "playbox", "worker"]
  group            = "playbox-cluster"
  private_ip       = true
  root_pass        = var.NODE_ROOT_PWD
  authorized_keys  = [trimspace(file(var.PUBLIC_KEY_PATH))]
  authorized_users = [data.linode_profile.me.username]
}

output "public_ip" {
  value = linode_instance.playbox.ip_address
}


output "private_ip" {
  value = linode_instance.playbox.private_ip_address
}


output "status" {
  value = linode_instance.playbox.status
}
