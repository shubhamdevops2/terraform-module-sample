terraform {
  backend "s3" {
    profile = "ssdev"
    bucket = "ssdev-s3-statefiles"
    dynamodb_table = "ssdev-s3-statelocks"
    encrypt = true
    kms_key_id = "arn:aws:kms:us-east-1:123456789:alias/ssdev-kms"
    key = "ssdev/aws-tf-project.tfstate"
    region = "us-east-1"
    
  }
}

