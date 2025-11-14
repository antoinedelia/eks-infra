provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "Environment" = "prod"
      "Project"     = "eks-infra"
      "Terraform"   = "true"
      "GitRepo"     = "https://github.com/antoinedelia/eks-infra"
    }
  }
}
