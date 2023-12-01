// Control Plane Segurity Group
resource "aws_security_group" "cluster_sg" {
  name   = "${var.cluster_name}-sg"
  vpc_id = aws_vpc.cluster_vpc.id

  egress {
    from_port = 0
    to_port   = 0

    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-sg"
  }

}

resource "aws_security_group_rule" "cluster_ingress_https" {
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"

  security_group_id = aws_security_group.cluster_sg.id
  type              = "ingress"
}

resource "aws_security_group_rule" "in_cluster_communication" {
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 10250
  to_port     = 10250
  protocol    = "tcp"

  security_group_id = aws_security_group.cluster_sg.id
  type              = "ingress"
}

//Nodes Security Group

resource "aws_security_group" "eks-node" {
  name        = "eks-worker-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = aws_vpc.cluster_vpc

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = (map(
    "Name", "eks-worker-node-sg",
    "kubernetes.io/cluster/${var.cluster_name}", "owned"
  ))
}

resource "aws_security_group_rule" "eks-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks-node.id
  source_security_group_id = aws_security_group.eks-node.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "eks-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-node.id
  source_security_group_id = aws_security_group.eks-cluster.id
  to_port                  = 65535
  type                     = "ingress"
}

# HPA requires 443 to be open for k8s control plane.
resource "aws_security_group_rule" "eks-node-ingress-hpa" {
  description              = "Allow HPA to receive communication from the cluster control plane"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-node.id
  source_security_group_id = aws_security_group.eks-cluster.id
  to_port                  = 443
  type                     = "ingress"
}
