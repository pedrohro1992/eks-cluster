resource "helm_release" "argocd_ingress" {
  count            = var.enable_ingress ? 1 : 0
  name             = var.cluster_name
  namespace        = var.ingress_helm_namespace
  create_namespace = true
  chart            = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  version          = var.ingress_controller_version

  values = [
    local.ingress_argocd_release_values
  ]

  dynamic "set" {
    for_each = var.ingress_controller_values
    content {
      name  = set.key
      value = set.value
    }
  }
  dynamic "set" {
    for_each = var.additional_set
    content {
      name  = set.value.name
      value = set.value.value
      type  = lookup(set.value, "type", null)
    }
  }

  depends_on = [aws_eks_node_group.cluster]
}
