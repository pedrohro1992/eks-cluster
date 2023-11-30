terraform {
  backend "s3" {
    bucket         = "terraform-state-e87"
    key            = "eks-cluster/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
