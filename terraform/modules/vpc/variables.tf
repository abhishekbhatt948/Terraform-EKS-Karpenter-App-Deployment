variable "region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging and discovery"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}
  variable "cluster_name" {
  description = "EKS cluster name for tagging and discovery"
  type        = string
  }