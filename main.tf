resource "null_resource" "cluster" {
  for_each = toset(var.k3d_cluster_name)
  triggers = {
    agent_count  = var.agent_count
    server_count = var.server_count
  }
  provisioner "local-exec" {
    command = "k3d cluster create ${each.key} --agents ${var.agent_count} --servers ${var.server_count}"
  }
}

resource "null_resource" "kubeconfig" {
  for_each = toset(var.k3d_cluster_name)
  depends_on = [
    null_resource.cluster
  ]
  provisioner "local-exec" {
    command = "export TF_VAR_kubeconfig=$(k3d kubeconfig write ${each.key})"
  }
}

resource "null_resource" "cluster_delete" {
  for_each = toset(var.k3d_cluster_name)
  provisioner "local-exec" {
    command = "k3d cluster delete ${each.key}"
    when    = destroy
  }
}
