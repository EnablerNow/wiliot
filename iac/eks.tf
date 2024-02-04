module "wiliot_eks" {
  source          = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "Wiliot-EKS-Cluster"
  cluster_version = "1.28"
  cluster_endpoint_public_access  = true
  

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id          = aws_vpc.wiliot_vpc.id
  subnet_ids      = [
    aws_subnet.wiliot_subnet1.id,
    aws_subnet.wiliot_subnet2.id,
  ]
  

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m4.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["m4.large"]
      capacity_type  = "SPOT"
    }
  }
  # Additional EKS configuration
  tags = {
    Environment = "production"
    Project     = "Wiliot"
  }
}
