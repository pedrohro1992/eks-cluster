resource "aws_eks_addon" "csi_driver" {
  cluster_name = aws_eks_cluster.cluster.name
  addon_name   = "aws-ebs-csi-driver"

  addon_version = "v1.26.0-eksbuild.1"
  //TODO remove deprecated argument
  resolve_conflicts = "OVERWRITE"

  depends_on = [
    aws_eks_node_group.cluster,
    kubernetes_config_map.aws-auth
  ]

}

//TODO Arrumar o CSI Driver (IAM Service Account)
