terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "kriti-3tier-tfstate-1324"
    key          = "3tier/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
    encrypt      = true
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project   = "3tier-app"
      ManagedBy = "terraform"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"

  name                 = "3tier"
  vpc_cidr             = "10.0.0.0/16"
  azs                  = ["ap-south-1a", "ap-south-1b"]
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
  enable_nat_gateway   = var.enable_nat_gateway
}

module "security" {
  source = "./modules/security"

  name   = "3tier"
  vpc_id = module.vpc.vpc_id
}

module "ecr" {
  source = "./modules/ecr"

  name = "3tier-app"
}

module "alb" {
  source = "./modules/alb"

  name              = "3tier"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security.alb_sg_id
}