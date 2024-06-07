resource "helm_release" "cert_manager" {
  count            = var.cert_manager_enable ? 1 : 0
  name             = var.cert_manger_release_name
  namespace        = var.cert_manger_release_name
  create_namespace = true
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  version          = var.cert_manager_release_version

  values = [
    templatefile("${path.module}/templates/cert_manager_values.yaml.tpl", {
      serviceAccountname = local.cert_manager_sa_name
      role               = aws_iam_role.cert_manager.arn
    })
  ]
  depends_on = [helm_release.external_dns]
}
