resource "helm_release" "fluent_bit" {
  name       = "fluent-bit"
  namespace  = "logging"
  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluent-bit"
  version    = "0.46.8"

  values = [yamlencode({
    serviceAccount = {
      create = true
      name   = "fluent-bit"
    }

    config = {
      inputs = <<-EOT
        [INPUT]
            Name              tail
            Path              /var/log/containers/*.log
            Parser            docker
            Tag               kube.*
            Mem_Buf_Limit     10MB
            Skip_Long_Lines   On
      EOT

      filters = <<-EOT
        [FILTER]
            Name                kubernetes
            Match               kube.*
            Kube_Tag_Prefix     kube.var.log.containers.
            Merge_Log           On
            Keep_Log            Off
      EOT

      outputs = <<-EOT
        [OUTPUT]
            Name  es
            Match kube.*
            Host  elasticsearch-master
            Port  9200
            Index kubernetes-logs
            Logstash_Format On
      EOT
    }

    tolerations = [{
      operator = "Exists"
    }]
  })]

  depends_on = [helm_release.elasticsearch]
}
