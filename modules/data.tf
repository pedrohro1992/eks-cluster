data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}

data "aws_eks_cluster_auth" "default" {
  name = aws_eks_cluster.cluster.id
}

data "tls_certificate" "eks" {
  url = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

data "aws_vpc" "this" {
  tags = {
    Name = "cacetinho-empresa-us-east-1-vpc"
  }
}

data "aws_security_group" "wireguard_vpn_sg" {
  tags = {
    Application = "wireguard"
  }
}

data "aws_subnet" "public" {
  // Gambiarra pra poder usar o data source pra uma subnet
  count = length(local.azs)
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
  tags = {
    Name = "${var.vpc_name}-public-${local.azs[count.index]}"
  }
}

data "aws_subnet" "private" {
  // Gambiarra pra poder usar o data source pra uma subnet
  count = length(local.azs)
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
  tags = {
    Name = "${var.vpc_name}-public-${local.azs[count.index]}"
  }
}
