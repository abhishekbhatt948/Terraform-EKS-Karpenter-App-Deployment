data "aws_iam_openid_connect_provider" "eks" {
  arn = var.oidc_provider_arn
}

resource "aws_iam_role" "karpenter_controller" {
  name = "${var.cluster_name}-karpenter-controller-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_provider_arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${replace(data.aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub" = "system:serviceaccount:karpenter:karpenter",

          "${replace(data.aws_iam_openid_connect_provider.eks.url, "https://", "")}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })
}

resource "aws_iam_policy" "karpenter_controller" {
  name = "${var.cluster_name}-karpenter-controller-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
            # EKS
            "eks:DescribeCluster",

            # EC2 discovery
            "ec2:DescribeInstances",
            "ec2:DescribeInstanceTypes",
            "ec2:DescribeInstanceTypeOfferings",
            "ec2:DescribeAvailabilityZones",
            "ec2:DescribeImages",
            "ec2:DescribeSubnets",
            "ec2:DescribeSecurityGroups",
            "ec2:DescribeSpotPriceHistory",

            # EC2 provisioning
            "ec2:RunInstances",
            "ec2:TerminateInstances",

            # Launch Template (CRITICAL)
            "ec2:CreateLaunchTemplate",
            "ec2:CreateLaunchTemplateVersion",
            "ec2:DeleteLaunchTemplate",
            "ec2:DeleteLaunchTemplateVersions",
            "ec2:DescribeLaunchTemplates",
            "ec2:DescribeLaunchTemplateVersions",
            "ec2:ModifyLaunchTemplate",

            # Tagging (CRITICAL)
            "ec2:TagResource",
            "ec2:UntagResource",

            # Pricing
            "pricing:GetProducts",

            # SSM
            "ssm:GetParameter",

            # IAM instance profile lifecycle
            "iam:GetInstanceProfile",
            "iam:CreateInstanceProfile",
            "iam:DeleteInstanceProfile",
            "iam:AddRoleToInstanceProfile",
            "iam:RemoveRoleFromInstanceProfile",
            "iam:TagInstanceProfile",
            "iam:PassRole"
          ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "karpenter_attach" {
  role       = aws_iam_role.karpenter_controller.name
  policy_arn = aws_iam_policy.karpenter_controller.arn
}