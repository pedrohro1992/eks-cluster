resource "helm_release" "argocd_ingress" {
  count            = var.enable_ingress ? 1 : 0
  name             = var.cluster_name
  namespace        = "ingress-argocd"
  create_namespace = true
  chart            = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  version          = var.ingress_controller_version

  dynamic "set" {
    for_each = var.ingress_controller_values
    content {
      name  = set.key
      value = set.value
    }
  }
  depends_on = [aws_eks_node_group.cluster]
}
