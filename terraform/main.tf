module "eks-cluster" {
  source = "../modules"

  cluster_name = "cacetinho-sa-eks"

  vpc_name = "cacetinho-empresa-us-east-1"


  node_group = {
    "ng1" = {
      instance_types = ["t3.medium"]
      desired_size   = 2
      max_size       = 2
      min_size       = 2
    }
  }
  cluster_version = "1.26"

  enable_ingress = true

  ingress_controller_version = "4.5.2"

  ingress_helm_namespace = "ingress-argocd"

  additional_set = [
    # {
    #   name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    #   value = "nlb"
    #   type  = "string"
    # },
    {
      name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-cross-zone-load-balancing-enabled"
      value = "true"
      type  = "string"
    },
  ]

  r53_public_zone_domain = "cacetinho.app.br"

}
