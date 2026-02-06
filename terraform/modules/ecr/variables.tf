variable "repository_name" {
  type        = string
  description = "ECR repository name"
  default = "demo-nodejs-app"
}

variable "environment" {
  type        = string
  description = "Environment name (dev/demo/prod)"
  default     = "demo"
}