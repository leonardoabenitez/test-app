terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #  version = "~> 5.7.0"
    }
  }


}

provider "aws" {
  region  = var.aws_region
  profile = local.aws_profile
}
