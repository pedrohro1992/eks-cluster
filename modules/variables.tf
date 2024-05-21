## General porpuse variables 
variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
}

variable "vpc_name" {
  type        = string
  description = "Name of vpc witch the cluster will be deployed"
}

## Eks cluster variables 

variable "node_group" {
  type = map(object({
    instance_types = list(string)
    desired_size   = number
    max_size       = number
    min_size       = number
  }))
  description = "Defntion for the node groups"
}

variable "cluster_version" {
  type        = string
  description = "Version of Kubernetes"
}

# Ingress controller variables

variable "enable_ingress" {
  type        = bool
  description = "Deploy the ingress controller. Defaults to false"
  default     = false
}

variable "ingress_helm_namespace" {
  type        = string
  description = "Set the ingress helm release namespace"
}

variable "ingress_controller_version" {
  type        = string
  description = "Set the version of helm chart"
}

variable "ingress_controller_values" {
  type    = map(any)
  default = {}
}

variable "additional_set" {
  description = "Optional set for additional helm settings"
  default     = []
}

# Route 53 Variables

variable "r53_public_zone_domain" {
  description = "Domain of the private route53 zone"
}
