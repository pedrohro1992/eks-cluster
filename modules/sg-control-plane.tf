//TODO Adicionar security group por pod no cluster https://medium.com/@seifeddinerajhi/aws-eks-security-groups-per-pod-improve-the-security-of-your-kubernetes-clusters-a23a961793dc
// Control Plane Segurity Group
resource "aws_security_group" "cluster_sg" {
  name   = "${var.cluster_name}-sg"
  vpc_id = data.aws_vpc.this.id

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
  source_security_group_id = data.aws_security_group.wireguard_vpn_sg.id
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"

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

