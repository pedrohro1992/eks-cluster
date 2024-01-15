# Allow EC2 instances to assume the IAM role
data "aws_iam_policy_document" "rode_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}


# Create an IAM role for the node group
resource "aws_iam_role" "node_group" {
  name               = "${var.cluster_name}-node-group"
  assume_role_policy = data.aws_iam_policy_document.rode_assume_role.json
}

resource "aws_iam_instance_profile" "nodes" {
  name = "${var.cluster_name}-instance-profile"
  role = aws_iam_role.node_group.name
}

# Attach the permissions the node group needs
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group.name
}

