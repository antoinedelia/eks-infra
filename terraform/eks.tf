module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = "1.33"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    general_purpose = {
      instance_type = "t3.small"
      min_size      = 1
      max_size      = 2
      desired_size  = 1
    }
  }
}
