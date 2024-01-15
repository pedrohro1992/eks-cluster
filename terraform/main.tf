module "eks-cluster" {
  source = "../modules"

  cluster_name = "eks-lab"
  vpc_cidr     = "10.0.0.0/16"

  public_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]

  private_subnets = [
    "10.0.10.0/24",
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]

  node_group = {
    "ng1" = {
      instance_types = ["t3.medium"]
      desired_size   = 2
      max_size       = 2
      min_size       = 2
    }
  }
  cluster_version = "1.26"
}
