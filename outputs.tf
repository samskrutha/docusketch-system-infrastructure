output "eks_cluster_AmazonEKSClusterPolicy" {
  value = aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy.id
}

output "eks_cluster_AmazonEKSServicePolicy" {
  value = aws_iam_role_policy_attachment.eks_cluster_AmazonEKSServicePolicy.id
}

output "eks_node_AmazonEKSWorkerNodePolicy" {
  value = aws_iam_role_policy_attachment.eks_node_AmazonEKSWorkerNodePolicy.id
}

output "eks_node_AmazonEKS_CNI_Policy" {
  value = aws_iam_role_policy_attachment.eks_node_AmazonEKS_CNI_Policy.id
}

output "eks_node_AmazonEC2ContainerRegistryReadOnly" {
  value = aws_iam_role_policy_attachment.eks_node_AmazonEC2ContainerRegistryReadOnly.id
}
