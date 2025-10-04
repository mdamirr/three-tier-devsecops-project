# Specify the backend configuration for storing Terraform state files in S3.
terraform {
  backend "s3" {
    bucket         = "3-tier-devops-project-bucket-s3"
    region         = "us-west-2"
    # The key (path) within the S3 bucket for storing the state file.
    key            = "three-tier-devsecops-project/jenkins-server-terraform/terraform.tfstate"
    # The DynamoDB table used for state locking to prevent concurrent state changes.
    dynamodb_table = "lock-files"
    encrypt        = true
  }

  required_providers {
    aws = {
      # The minimum version of the AWS provider required for this configuration.
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}
