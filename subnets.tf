resource "aws_subnet" "public" {
  count      = length(local.azs)
  vpc_id     = aws_vpc.cluster_vpc.id
  cidr_block = var.cidr_block_public[count.index]

  availability_zone = local.azs[count.index]
  tags = {
    Name                              = "${var.cluster_name}-public-${local.azs[count.index]}"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_subnet" "private" {
  count      = length(local.azs)
  vpc_id     = aws_vpc.cluster_vpc.id
  cidr_block = var.cidr_block_private[count.index]

  availability_zone = local.azs[count.index]
  tags = {
    Name                     = "${var.cluster_name}-private-${local.azs[count.index]}"
    "kubernetes.io/role/elb" = 1
  }
}
