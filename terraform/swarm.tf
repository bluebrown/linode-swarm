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

# get profile data
data "linode_profile" "me" {}

# create manager nodes
resource "linode_instance" "swarm_manager" {
  count            = var.MANAGER_COUNT
  label            = "swarm-manager-${count.index}"
  image            = "linode/ubuntu20.04"
  type             = "g6-nanode-1"
  region           = "eu-west"
  tags             = ["terraform", "ansible", "docker", "swarm", "manager"]
  group            = "swarm-cluster"
  private_ip       = true
  root_pass        = var.NODE_ROOT_PWD
  authorized_keys  = [trimspace(file(var.PUBLIC_KEY_PATH))]
  authorized_users = [data.linode_profile.me.username]
}

# create worker nodes
resource "linode_instance" "swarm_worker" {
  count            = var.MANAGER_COUNT
  label            = "swarm-worker-${count.index}"
  image            = "linode/ubuntu20.04"
  type             = "g6-nanode-1"
  region           = "eu-west"
  tags             = ["terraform", "ansible", "docker", "swarm", "worker"]
  group            = "swarm-cluster"
  private_ip       = true
  root_pass        = var.NODE_ROOT_PWD
  authorized_keys  = [trimspace(file(var.PUBLIC_KEY_PATH))]
  authorized_users = [data.linode_profile.me.username]
}

# register cluster domain
resource "linode_domain" "cluster_domain" {
  type      = "master"
  domain    = var.DOMAIN_NAME
  soa_email = data.linode_profile.me.email
  tags      = ["terrafrom", "swarm"]
}

# set up dns round robin to manager nodes where traefik will be deployed
resource "linode_domain_record" "manager_nodes" {
  count       = var.MANAGER_COUNT
  domain_id   = linode_domain.cluster_domain.id
  record_type = "A"
  name        = "www"
  port        = 80
  priority    = 10
  weight      = 5
  target      = linode_instance.swarm_manager[count.index].ip_address
}
