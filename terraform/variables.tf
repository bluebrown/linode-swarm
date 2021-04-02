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

variable "PRIVATE_KEY_PATH" {
  type      = string
  default   = "../secrets/playbox"
  sensitive = true
}

variable "PUBLIC_KEY_PATH" {
  type      = string
}
