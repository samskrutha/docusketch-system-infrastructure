variable "region" {
  description = "The AWS region to create resources in"
  default     = "us-west-2"
  type        = string
}
variable "cluster_name" {
  description = "The name of the EKS cluster"
  default     = "my-cluster"
  type        = string
}
variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}
variable "node_group_name" {
  description = "The name of the EKS node group"
  default     = "my-node-group"
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
