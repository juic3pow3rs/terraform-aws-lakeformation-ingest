locals {
  location         = "eu-central-1"
  environment      = "dev"
  project          = "ws2223"
  template_version = "0.0.1"
  team             = "andizzo"
  role             = "cloud01"
}

data "aws_caller_identity" "current" {}

data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

module "s3_bucket" {
  source = "./terraform-aws-modules/s3"
  providers = {
    aws = aws.ffm
  }

  environment      = local.environment
  role             = local.role
  project          = local.project
  template_version = local.template_version
  team             = local.team
}

module "lakeformation" {
  source = "./terraform-aws-modules/lakeformation"
  providers = {
    aws = aws.ffm
  }

  admin_user_arn = data.aws_iam_session_context.current.issuer_arn
  s3_bucket_arn = module.s3_bucket.s3_bucket_arn
  s3_bucket_name = module.s3_bucket.s3_bucket_name
  file_name = "demoLakeData.csv"
  file_source = "./demoLakeData.csv"

  environment      = local.environment
  role             = local.role
  project          = local.project
  template_version = local.template_version
  team             = local.team
}

