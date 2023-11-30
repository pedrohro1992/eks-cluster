## General porpuse variables 
variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
}
## Network variables 

variable "vpc_cidr" {
  type        = string
  description = "CIDR Block to put on the vpc"
}



variable "cidr_block_public" {
  type        = list(string)
  description = "CIDR Block to put on the public subnets"
}

variable "cidr_block_private" {
  type        = list(string)
  description = "CIDR to put on the private subnetes"
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
