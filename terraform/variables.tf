variable "LINODE_TOKEN" {
  description = "the token to manage linode"
  type        = string
  sensitive   = true
}

variable "NODE_ROOT_PWD" {
  description = "root pwd for new created nanode resources"
  type        = string
  sensitive   = true
}

variable "PUBLIC_KEY_PATH" {
  description = "public  ssh key that is added to the nodes"
  type      = string
  sensitive = true
}

variable "MANAGER_COUNT" {
  description = "count of swarm manager nodes"
  type      = number
}

variable "WORKER_COUNT" {
  description = "count of swarm worker nodes"
  type      = number
}

variable "DOMAIN_NAME" {
  description = "owned domain name"
  type      = string
}
