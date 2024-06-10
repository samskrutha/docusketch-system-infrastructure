variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "eu-west-1"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "docusketch-vpc"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "docusketch-cluster"
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  type        = string
  default     = "docusketch-node-group"
}

variable "desired_capacity" {
  description = "The desired number of nodes in the node group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum number of nodes in the node group"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "The minimum number of nodes in the node group"
  type        = number
  default     = 1
}

variable "ssh_key_name" {
  description = "The SSH key name for the EKS node group"
  type        = string
  default     = "eksKeyPair"
}
