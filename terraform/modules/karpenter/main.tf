terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
}
resource "kubectl_manifest" "nodeclass" {
  yaml_body = <<YAML
apiVersion: karpenter.k8s.aws/v1beta1
kind: EC2NodeClass
metadata:
  name: default
spec:
  role: ${var.cluster_name}-node-role
  amiFamily: AL2023
  # amiSelectorTerms:
  #   - alias: al2@latest
  subnetSelectorTerms:
    - tags:
        karpenter.sh/discovery: ${var.cluster_name}
  securityGroupSelectorTerms:
    - tags:
        karpenter.sh/discovery: ${var.cluster_name}
YAML

  depends_on = [helm_release.karpenter]
}


resource "kubectl_manifest" "nodepool" {
  yaml_body = <<YAML
apiVersion: karpenter.sh/v1beta1
kind: NodePool
metadata:
  name: default
spec:
  template:
    spec:
      nodeClassRef:
        name: default
      requirements:
        - key: kubernetes.io/arch
          operator: In
          values: ["amd64"]

        - key: kubernetes.io/os
          operator: In
          values: ["linux"]

        - key: karpenter.k8s.aws/instance-category
          operator: In
          values: ["t", "m", "c"]

        - key: karpenter.k8s.aws/instance-generation
          operator: Gt
          values: ["2"]

        - key: karpenter.sh/capacity-type
          operator: In
          values: ["on-demand", "spot"]
  limits:
    cpu: "1000"
    memory: "1000Gi"
YAML

  depends_on = [helm_release.karpenter]
}

