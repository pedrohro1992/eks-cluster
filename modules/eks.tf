# Allow EKS to assume the IAM role
resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version  = var.cluster_version

  vpc_config {
    security_group_ids = [
      aws_security_group.cluster_sg.id,
      aws_security_group.nodes_sg.id
    ]
    subnet_ids = [
      aws_subnet.private[0].id,
      aws_subnet.private[1].id,
      aws_subnet.private[2].id
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after the EKS cluster. Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_subnet.public,
    aws_subnet.private
  ]
}


