module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = ">= 3.0"
  name            = "eks-vpc-${terraform.workspace}"
  cidr            = "10.0.0.0/16"
  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  name            = "eks-cluster-${terraform.workspace}"
  version         = "1.28"
  subnets         = concat(module.vpc.public_subnets, module.vpc.private_subnets)
  vpc_id          = module.vpc.vpc_id
  manage_aws_auth = true
  # node groups, fargate etc...
  node_groups = { default = {
    desired_capacity = 2
    instance_type    = "t3.medium"
    }
  }
  # create OIDC provider for the cluster (module supports it)
  create_oidc = true
}
