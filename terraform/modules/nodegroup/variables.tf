variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for the EKS node group"
}
