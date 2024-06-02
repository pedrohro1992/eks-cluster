## General porpuse variables 
variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
}

variable "vpc_name" {
  type        = string
  description = "Name of vpc witch the cluster will be deployed"
}

variable "public_zone" {
  type        = string
  description = "Public Zone with the cluster will be access from the internet"
}

variable "cluster_region" {
  type        = string
  description = "Region that the eks cluster will be deployed"
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

# Ingress controller variable

variable "enable_ingress" {
  type        = bool
  description = "Deploy the ingress controller. Defaults to false"
  default     = false
}

variable "ingress_controller_version" {
  type        = string
  description = "Set the version of helm chart"
}

#TODO: Nao sei se isso ta funcionando
variable "ingress_controller_values" {
  type    = map(any)
  default = {}
}

// External DNS Values
variable "external_dns_release_name" {
  type        = string
  description = "Set the external_dns release name for the external DNS install"
}

variable "external_dns_release_version" {
  type        = string
  description = "Set the service account name that will be used by the external dns operator"
}


