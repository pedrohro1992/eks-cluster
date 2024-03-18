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

variable "ingress_controller_values" {
  type    = map(any)
  default = {}
}
