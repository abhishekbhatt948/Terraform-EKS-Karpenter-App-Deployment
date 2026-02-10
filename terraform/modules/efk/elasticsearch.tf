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

resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  namespace  = var.namespace
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  version    = var.elasticsearch_chart_version

  create_namespace = true
  timeout          = 300
  wait             = true

  values = [yamlencode({
    replicas = 1
    minimumMasterNodes = 1

    persistence = {
      enabled = false
    }

    resources = {
      requests = {
        cpu    = "250m"
        memory = "512m"
      }
      limits = {
        cpu    = "500m"
        memory = "1Gi"
      }
    }
    
  })]
}
