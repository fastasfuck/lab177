provider "aws" {
  profile = "default"
  region  = "us-east-1"
  alias  = "dev"

}

provider "aws" {
  profile = "default"
  region  = "us-east-2"

  alias = "prod"
  access_key = "AKIATUJQOMZMQHLUGCXX"
  secret_key = "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"
}

module "vpc_rds_creating" {
  source = "./modules/vpc"
  env                  = "dev"
  vpc_cidr             = "10.100.0.0/16"
  public_subnet_cidrs  = ["10.100.1.0/24", "10.100.2.0/24"]
  private_subnet_cidrs = []
  ecs_cluster_name     = "rdstest"
  task_name            = "rdstasktest"
}
module "ec2_creating" {
  source = "./modules/ec2"
}
module "s3_creating" {
  providers = {
    aws.prod = aws.prod
    aws.dev  = aws.dev
  }
  source = "./modules/s3"
  bucket_name = "teeeestfaaast123"
}
