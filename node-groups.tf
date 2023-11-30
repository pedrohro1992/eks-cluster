resource "aws_eks_node_group" "cluster" {

  for_each = var.node_group

  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = each.key
  node_role_arn   = aws_iam_role.node_group.arn

  subnet_ids = [
    aws_subnet.private[*].ids
  ]

  instance_types = var.node_group[each.key].instance_types

  scaling_config {
    desired_size = var.node_group[each.key].desired_size
    max_size     = var.node_group[each.key].max_size
    min_size     = var.node_group[each.key].min_size
  }

  tags = {
    "kubernetes.io/cluster/${var.cluster_name}"     = "owned",
    "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
  }


  depends_on = [
    kubernetes_config_map.aws-auth
  ]

  timeouts {
    create = "60m"
    update = "2h"
    delete = "2h"
  }
}
