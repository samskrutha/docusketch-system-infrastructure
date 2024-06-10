module "vpc" {
  source     = "./modules/vpc"
  vpc_name   = var.vpc_name
  cidr_block = var.cidr_block
}

module "eks" {
  source                    = "./modules/eks"
  cluster_name              = var.cluster_name
  cluster_role_arn          = aws_iam_role.eks_cluster_role.arn
  subnet_ids                = module.vpc.public_subnets
  node_group_name           = var.node_group_name
  node_role_arn             = aws_iam_role.eks_node_role.arn
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  cluster_security_group_id = aws_security_group.eks_cluster_sg.id
  node_security_group_id    = aws_security_group.eks_node_sg.id
  node_role_name            = aws_iam_role.eks_node_role.name
}