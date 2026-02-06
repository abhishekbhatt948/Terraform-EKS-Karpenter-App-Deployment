variable "region" {
  description = "AWS region for all resources"
  type        = string
  default     = "ap-south-1"
}
variable "project_name" {
  description = "Project identifier used for tagging and naming"
  type        = string
  default     = "eks-demo"
}
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "eks-demo-dev"
}
variable "ecr_repository_name" {
  type        = string
  description = "ECR repository name"
  default = "app"
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}