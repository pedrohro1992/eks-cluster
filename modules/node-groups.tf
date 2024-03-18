resource "tls_private_key" "eks" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name = "${var.cluster_name}-key_name"

  public_key = tls_private_key.eks.public_key_openssh
  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.eks.private_key_pem}' > ${var.cluster_name}.pem"
  }
}


resource "aws_eks_node_group" "cluster" {

  for_each = var.node_group

  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = each.key
  node_role_arn   = aws_iam_role.node_group.arn

  subnet_ids = [
    data.aws_subnet.private[0].id,
    data.aws_subnet.private[1].id,
    data.aws_subnet.private[2].id
  ]

  instance_types = var.node_group[each.key].instance_types

  scaling_config {
    desired_size = var.node_group[each.key].desired_size
    max_size     = var.node_group[each.key].max_size
    min_size     = var.node_group[each.key].min_size
  }

  remote_access {
    ec2_ssh_key = aws_key_pair.generated_key.key_name
  }

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }


  # depends_on = [
  #   kubernetes_config_map.aws-auth
  # ]

  timeouts {
    create = "10m"
    update = "1h"
    delete = "1h"
  }
}

// TODO  https://github.com/miqdigital/terraform-aws-eks-cluster/tree/master continuar daqui, os node ainda não estão conectando - usar exemplo do github pra tentar configurar isso
