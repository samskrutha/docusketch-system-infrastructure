variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_role_arn" {
  description = "The IAM role for the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  type        = string
}

variable "node_role_arn" {
  description = "The IAM role for the EKS node group"
  type        = string
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

variable "cluster_security_group_id" {
  description = "The security group ID for the EKS cluster"
  type        = string
}

variable "node_security_group_id" {
  description = "The security group ID for the EKS nodes"
  type        = string
}

variable "ssh_key_name" {
  description = "The SSH key name for the EKS node group"
  type        = string
}

variable "node_role_name" {
  description = "The name of the IAM role for the EKS node group"
  type        = string
}
