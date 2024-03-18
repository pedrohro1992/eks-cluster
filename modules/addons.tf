//resource "aws_eks_addon" "csi_driver" {
//  cluster_name = aws_eks_cluster.cluster.name
//  addon_name   = "aws-ebs-csi-driver"
//
//  addon_version = "v1.26.0-eksbuild.1"
//  //TODO remove deprecated argument
//  resolve_conflicts = "OVERWRITE"
//
//  depends_on = [
//    aws_eks_node_group.cluster,
//    kubernetes_config_map.aws-auth
//  ]
//
//}

//TODO Arrumar o CSI Driver (IAM Service Account)

resource "aws_eks_addon" "csi_driver" {
  cluster_name             = aws_eks_cluster.cluster.name
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = "v1.26.0-eksbuild.1"
  service_account_role_arn = aws_iam_role.eks_ebs_csi_driver.arn

  depends_on = [
    aws_eks_node_group.cluster,
    # Comentando porque por algum motivo o terraform ta destruindo alguma coisa na ordem errada e eu perco acesso ao cluster (talvez seja regra de sg)
    kubernetes_config_map.aws-auth
  ]
}
