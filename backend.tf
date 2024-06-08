terraform {
  backend "s3" {
    bucket         = "docusketch-terraform-state-bucket"
    key            = "terraform/eks/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "docusketch-terraform-lock-table"
  }
}
