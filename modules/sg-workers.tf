resource "aws_security_group" "nodes_sg" {
  name        = "eks-worker-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = data.aws_vpc.this.id

  ingress {
    description     = "Allow node to communicate with each other"
    from_port       = 65535
    to_port         = 65535
    protocol        = "-1"
    security_groups = aws_security_group.cluster_sg.id
  }
  ingress {
    description     = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
    from_port       = 1025
    to_port         = 65535
    protocol        = "tcp"
    security_groups = aws_security_group.cluster_sg.id
  }
  ingress {
    description     = "Allow HPA to receive communication from the cluster control plane"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = aws_security_group.cluster_sg.id
  }
  egress {
    description = "Allow cluster to communicate with internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name                                        = "eks-worker-node-sg",
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }
}


