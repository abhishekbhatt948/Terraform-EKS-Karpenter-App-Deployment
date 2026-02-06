variable "namespace" {
  description = "Namespace for EFK stack"
  type        = string
  default     = "logging"
}

variable "elasticsearch_chart_version" {
  type    = string
  default = "7.17.3"
}

variable "kibana_chart_version" {
  type    = string
  default = "7.17.3"
}
variable "fluent_bit_chart_version" {
  description = "Fluent Bit Helm chart version"
  type        = string
  default     = "0.46.8"
}

variable "elasticsearch_storage_size" {
  description = "Persistent volume size for Elasticsearch"
  type        = string
  default     = "2Gi"
}
