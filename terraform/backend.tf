terraform {
  backend "s3" {
    bucket         = "eks-demo-terraform-state-047038669736"
    key            = "eks/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}