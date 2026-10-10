variable "aws_region" {
  description = "AWS region for the demo EKS cluster"
  type        = string
  default     = "ap-south-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "platform-demo-eks"
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version supported by your AWS account and module version"
  type        = string
  default     = "1.31"
}

variable "vpc_id" {
  description = "Existing VPC ID. Supply a VPC suitable for EKS."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs in at least two Availability Zones"
  type        = list(string)
}
