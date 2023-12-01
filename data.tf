//Get the name of azs 
data "aws_availability_zones" "available" {}

data "tls_certificate" "eks" {
  url = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

data "aws_eks_cluster_auth" "default" {
  name = aws_eks_cluster.cluster.id
}

data "aws_caller_identity" "current" {}
