resource "helm_release" "external_dns" {
  #Remover quando a instalacao tiver configurada
  #
  name             = var.external_dns_release_name
  namespace        = var.external_dns_release_name
  create_namespace = true
  chart            = "external-dns"
  repository       = "https://kubernetes-sigs.github.io/external-dns"
  version          = var.external_dns_release_version

  values = [
    templatefile("${path.module}/templates/external_dns_values.yaml.tpl", {
      region             = var.cluster_region
      serviceAccountname = local.external_dns_sa_name
      role               = aws_iam_role.external_dns.arn
    })
  ]
  depends_on = [aws_eks_node_group.cluster]
}
