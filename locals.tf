locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  eks-node-private-userdata = <<USERDATA
#!/bin/bash -xe

sudo /etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.cluster.endpoint}' --b64-cluster-ca '${aws_eks_cluster.cluster.certificate_authority.0.data}' '${var.cluster_name}'

USERDATA

}
