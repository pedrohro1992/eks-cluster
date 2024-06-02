locals {
  azs                  = slice(data.aws_availability_zones.available.names, 0, 3)
  external_dns_sa_name = "${var.cluster_name}-${var.external_dns_release_name}-sa"

}
