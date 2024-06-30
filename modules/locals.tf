locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  #TODO Achar um jeito melhor pra montar o nome dessas service account
  external_dns_sa_name = "${var.cluster_name}-${var.external_dns_release_name}-sa"

  cert_manager_sa_name = "${var.cluster_name}-${var.cert_manger_release_name}-sa"

  lbc_sa_name = "${var.cluster_name}-${var.cert_manger_release_name}-sa"
}
