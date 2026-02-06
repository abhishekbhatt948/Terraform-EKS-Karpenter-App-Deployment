module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = var.vpc_cidr
  region       = var.region
  cluster_name = var.cluster_name
  project_name = var.project_name
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = var.cluster_name
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "nodegroup" {
  source             = "./modules/nodegroup"
  cluster_name       = module.eks.cluster_name
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "aws_auth" {
  source        = "./modules/aws-auth"
  node_role_arn = module.nodegroup.node_role_arn

  depends_on = [module.nodegroup]
}

module "karpenter" {
  source            = "./modules/karpenter"
  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  oidc_provider_arn = module.eks.oidc_provider_arn
  aws_region = var.region

  depends_on = [module.aws_auth]
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = var.ecr_repository_name
}

module "efk" {
  source = "./modules/efk"
}
