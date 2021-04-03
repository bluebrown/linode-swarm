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

resource "linode_instance" "swarm-node" {
  count            = 2
  label            = "swarm-node-${count.index}"
  image            = "linode/ubuntu20.04"
  type             = "g6-nanode-1"
  region           = "eu-west"
  tags             = ["terraform", "ansible", "docker", "swarm"]
  group            = "swarm-cluster"
  private_ip       = true
  root_pass        = var.NODE_ROOT_PWD
  authorized_keys  = [trimspace(file(var.PUBLIC_KEY_PATH))]
  authorized_users = [data.linode_profile.me.username]
}
