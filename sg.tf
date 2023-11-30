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

//Nodes Security Group

resource "aws_security_group" "cluster_nodes_sg" {
  name   = "${var.cluster_name}-nodes-sg"
  vpc_id = aws_vpc.cluster_vpc.id

  egress {
    from_port = 0
    to_port   = 0

    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-nodes-sg"
  }

}

resource "aws_security_group_rule" "nodeport" {
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 30000
  to_port     = 32768
  description = "nodeport"
  protocol    = "tcp"

  security_group_id = aws_security_group.cluster_nodes_sg.id
  type              = "ingress"
}
