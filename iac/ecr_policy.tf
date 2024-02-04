resource "aws_iam_policy" "ecr_access" {
  name        = "ecr-access"
  path        = "/"
  description = "ECR access policy for EKS worker nodes"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetAuthorizationToken"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ecr_custom_policy_attachment" {
  for_each = {
    "blue"  = module.wiliot_eks.eks_managed_node_groups.blue.iam_role_name
    "green" = module.wiliot_eks.eks_managed_node_groups.green.iam_role_name
  }

  policy_arn = aws_iam_policy.ecr_access.arn
  role       = each.value
}


# output test {
#     value = module.wiliot_eks.eks_managed_node_groups.blue.node_group_arn
# }