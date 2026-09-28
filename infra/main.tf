module "vpc" {
  source = "./modules/vpc"
}

module "alb" {
  source              = "./modules/alb"
  alb_vpc_id          = module.vpc.vpc_id
  alb_sg              = module.vpc.alb_sg
  public_subnet_cidrs = module.vpc.public_sub_id
  acm-arn             = module.acm.acm-arn
}

module "ecr" {
  source = "./modules/ecr"
}

module "ecs" {
  source               = "./modules/ecs"
  alb-target-group     = module.alb.alb-target-arn
  private_subnet_cidrs = module.vpc.private_sub_id
  security_group_id    = module.vpc.ecs_sg
}

module "dns" {
  source                = "./modules/dns"
  cloudflare_api_token  = var.api_token
  cloudflare_zone_id    = var.cloudflare_zone_id
  cloudflare_account_id = var.cloudflare_account_id
  alb_dns               = module.alb.alb_name
}

module "acm" {
  source             = "./modules/acm"
  cloudflare_zone_id = var.cloudflare_zone_id
  cloudflare_api_token = var.api_token 
}
