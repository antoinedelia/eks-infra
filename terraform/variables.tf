variable "aws_region" {
  description = "AWS region to deploy EKS"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-antoine"
}

variable "aws_eks_admin_iam_role_arn" {
  description = "The ARN of a local IAM user to grant 'system:masters' access to the EKS cluster"
  type        = string
}
