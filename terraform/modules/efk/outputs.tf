output "namespace" {
  description = "EFK namespace"
  value       = "efk"
}

output "elasticsearch_service" {
  description = "Elasticsearch service name"
  value       = "elasticsearch-master"
}

output "kibana_service" {
  description = "Kibana service name"
  value       = "kibana-kibana"
}

output "kibana_port" {
  description = "Kibana service port"
  value       = 5601
}
