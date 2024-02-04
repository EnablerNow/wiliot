resource "aws_ecr_repository" "wiliot_ecr_repo" {
  name                 = "wiliot-ecr-repo"
  image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository_policy" "example" {
  repository = aws_ecr_repository.wiliot_ecr_repo.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowPushPull"
        Effect = "Allow"
        Principal = "*"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ]
      }
    ]
  })
}
