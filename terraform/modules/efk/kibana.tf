terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }
}

resource "helm_release" "kibana" {
  name       = "kibana"
  namespace  = var.namespace
  repository = "https://helm.elastic.co"
  chart      = "kibana"
  version    = var.kibana_chart_version

  values = [yamlencode({
    elasticsearchHosts = "http://elasticsearch-master:9200"

    resources = {
      requests = {
        cpu    = "200m"
        memory = "512Mi"
      }
    }
  })]

  depends_on = [helm_release.elasticsearch]
}
