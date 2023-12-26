variable "k3d_cluster_name" {
  type = list(string)
}

variable "server_count" {
  default = 1
  type    = number
}

variable "agent_count" {
  default = 0
  type    = number
}
