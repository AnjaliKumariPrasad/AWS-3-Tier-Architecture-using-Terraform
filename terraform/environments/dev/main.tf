module "vpc" {

  source = "../../modules/vpc"

  vpc_cidr = "10.0.0.0/16"

  public_subnet_1_cidr = "10.0.1.0/24"
  public_subnet_2_cidr = "10.0.2.0/24"

  app_subnet_1_cidr = "10.0.11.0/24"
  app_subnet_2_cidr = "10.0.12.0/24"

  db_subnet_1_cidr = "10.0.21.0/24"
  db_subnet_2_cidr = "10.0.22.0/24"

  az1 = "ap-south-1a"
  az2 = "ap-south-1b"
}

module "security_groups" {

  source = "../../modules/security-groups"

  vpc_id = module.vpc.vpc_id

  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id

}

module "ecr" {

  source = "../../modules/ecr"
}

module "iam" {

  source = "../../modules/iam"
}

module "secrets_manager" {

  source = "../../modules/secrets-manager"

  db_username = "postgres"

  db_password = "anjali678!"

  db_name = "taskdb"
}

module "rds" {

  source = "../../modules/rds"

  db_subnet_1_id = module.vpc.db_subnet_1_id
  db_subnet_2_id = module.vpc.db_subnet_2_id

  db_sg_id = module.security_groups.rds_sg_id

  db_name = "taskdb"

  db_username = "postgres"

  db_password = "anjali678!"
}

module "alb" {

  source = "../../modules/alb"

  vpc_id = module.vpc.vpc_id

  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id

  app_subnet_1_id = module.vpc.app_subnet_1_id
  app_subnet_2_id = module.vpc.app_subnet_2_id

  external_alb_sg_id = module.security_groups.external_alb_sg_id
  internal_alb_sg_id = module.security_groups.internal_alb_sg_id
}

module "autoscaling" {

  source = "../../modules/autoscaling"

  frontend_lt_id = module.launch_template.frontend_lt_id

  backend_lt_id = module.launch_template.backend_lt_id

  frontend_tg_arn = module.alb.frontend_tg_arn

  backend_tg_arn = module.alb.backend_tg_arn

  public_subnet_1_id = module.vpc.public_subnet_1_id
  public_subnet_2_id = module.vpc.public_subnet_2_id

  app_subnet_1_id = module.vpc.app_subnet_1_id
  app_subnet_2_id = module.vpc.app_subnet_2_id
}

module "launch_template" {

  source = "../../modules/launch-template"

  frontend_sg_id = module.security_groups.frontend_sg_id

  backend_sg_id = module.security_groups.backend_sg_id

  instance_profile_name = module.iam.instance_profile_name
}