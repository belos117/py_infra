module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc-${terraform.workspace}"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "eks-cluster-${terraform.workspace}"
  kubernetes_version = "1.33"

  endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  create_auto_mode_iam_resources = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets_id

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}