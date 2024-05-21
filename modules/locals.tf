locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  ingress_argocd_release_values = templatefile("${path.module}/templates/values.yaml.tpl", {
    cluster_name = var.cluster_name
  })

}
