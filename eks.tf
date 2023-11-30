# Allow EKS to assume the IAM role
resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version  = 1.26

  vpc_config {
    security_group_ids = [
      aws_security_group.cluster_sg.id,
      aws_security_group.cluster_nodes_sg.id
    ]
    subnet_ids = [
      aws_subnet.private[*].id
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after the EKS cluster. Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_subnet.public,
    aws_subnet.private
  ]
}

