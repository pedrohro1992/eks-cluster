module "eks-cluster" {
  source = "../modules"

  //TODO:Bolar um nome melhor pro cluster, os recurso ta ficando com os nome tudo cagado
  cluster_name = "cacetinho-sa-eks"

  cluster_region = "us-east-1"

  vpc_name = "cacetinho-empresa-us-east-1"

  cluster_version = "1.29"

  public_zone = "cacetinho.app.br"

  node_group = {
    "ng1" = {
      instance_types = ["t3.medium"]
      desired_size   = 1
      max_size       = 2
      min_size       = 1
    },
    "ng2" = {
      instance_types = ["t3.medium"]
      desired_size   = 1
      max_size       = 2
      min_size       = 1
    }
  }

  #====================================================================================== #

  //Nginx Ingress Operator Values
  enable_ingress = true

  ingress_controller_version = "4.5.2"

  #====================================================================================== #

  //External DNS Values
  external_dns_release_name = "external-dns"

  external_dns_release_version = "1.14.4"

  #====================================================================================== #

  //Cert Manager Values
  cert_manager_enable = true

  cert_manger_release_name = "cert-manager"

  cert_manager_release_version = "1.14.5"

  #====================================================================================== #

  //Cert Manager Values
  lbc_release_name = ""
}
