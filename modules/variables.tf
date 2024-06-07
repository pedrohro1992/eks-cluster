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

variable "lbc_release_name" {
  type        = string
  description = "Set tne name of AWS LOad Balance Controller helm release"
}

// AWS Load Balance Controller Values

// Ingress Controller Values
variable "enable_ingress" {
  type        = bool
  description = "Deploy the ingress controller. Defaults to false"
  default     = false
}

variable "ingress_controller_version" {
  type        = string
  description = "Set the version of helm chart"
}

// External DNS Values
variable "external_dns_release_name" {
  type        = string
  description = "Set the name of external dns helm release"
}

variable "external_dns_release_version" {
  type        = string
  description = "Set the release version for external dns helm chart"
}

// Cert Manager Values
variable "cert_manager_enable" {
  type = bool
}

variable "cert_manger_release_name" {
  type        = string
  description = "Set the name of Cert Manager helm release"
}

variable "cert_manager_release_version" {
  type        = string
  description = "Set the release version for cert-manager helm chart"
}
