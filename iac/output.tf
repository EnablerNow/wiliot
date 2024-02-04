output "vpc_id" {
  value = aws_vpc.wiliot_vpc.id
}

output "subnet_ids" {
  value = [aws_subnet.wiliot_subnet1.id, aws_subnet.wiliot_subnet2.id]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.wiliot_gw.id
}

output "security_group_id" {
  value = aws_security_group.wiliot_sg.id
}

output "eks_cluster_id" {
  value = module.wiliot_eks.cluster_id
}

output "eks_cluster_arn" {
  value = module.wiliot_eks.cluster_arn
}

output "eks_cluster_endpoint" {
  value = module.wiliot_eks.cluster_endpoint
}

output "ecr_repository_url" {
  value = aws_ecr_repository.wiliot_ecr_repo.repository_url
}
