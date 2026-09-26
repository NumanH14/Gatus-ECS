module "vpc" {
  source = "./modules/vpc"
}

module "alb" {
  source              = "./modules/alb"
  alb_vpc_id          = module.vpc.vpc_id
  alb_sg              = module.vpc.alb_sg
  public_subnet_cidrs = module.vpc.public_sub_id
}

module "ecr" {
  source = "./modules/ecr"
}

module "ecs" {
  source               = "./modules/ecs"
  alb-target-group     = module.alb.alb-target-arn
  private_subnet_cidrs = module.vpc.private_sub_id
  security_group_id    = module.vpc.sg_id
}

module "dns" {
  source               = "./modules/dns"
  cloudflare_api_token = var.api_token
}

module "acm" {
  source = "./modules/acm"
}
