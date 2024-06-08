variable "region" {
  description = "The AWS region to create resources in"
  default     = "eu-west-1"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  default     = "docusketch-vpc"
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
  type        = string
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  default     = "docusketch-cluster"
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  default     = "docusketch-node-group"
  type        = string
}

variable "desired_capacity" {
  description = "The desired number of nodes in the node group"
  default     = 2
  type        = number
}

variable "max_size" {
  description = "The maximum number of nodes in the node group"
  default     = 3
  type        = number
}

variable "min_size" {
  description = "The minimum number of nodes in the node group"
  default     = 1
  type        = number
}
