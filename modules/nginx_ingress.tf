resource "helm_release" "external_ingress" {
  count            = var.enable_ingress ? 1 : 0
  name             = var.cluster_name
  namespace        = "ingress-external"
  create_namespace = true
  chart            = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  version          = var.ingress_controller_version

  values = [
    templatefile("${path.module}/templates/nginx_ingress_values.yaml.tpl", {})
  ]

  depends_on = [aws_eks_node_group.cluster]
}
