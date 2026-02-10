resource "helm_release" "karpenter" {
  name       = "karpenter"
  namespace  = "karpenter"
  repository = "oci://public.ecr.aws/karpenter"
  chart      = "karpenter"
  version    = "0.37.0"

  create_namespace = true

  wait            = true
  wait_for_jobs   = true
  timeout         = 600
  atomic          = false
  cleanup_on_fail = false

  
  skip_crds = false

  values = [
    yamlencode({
      settings = {
        clusterName     = var.cluster_name
        clusterEndpoint = var.cluster_endpoint
      }
      serviceAccount = {
        annotations = {
          "eks.amazonaws.com/role-arn" = aws_iam_role.karpenter_controller.arn
        }
      }
    })
  ]
}
