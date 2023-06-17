variable "region" {
  type    = string
  description = "The default region for our Project" 
}

# VPC
variable "vpc_cidr_block" {
  type        = string
  description = "The cidr range for the VPC"
}

variable "pubsubnet_cidr_block" {
  type        = string
  description = "The cidr range for the public subnet"
}

variable "privsubnet_cidr_block" {
  type        = string
  description = "The cidr range for the private subnet"
}

variable "pubsubnet_az" {
  type        = string
  description = "The availability zone for the public subnet"
}

variable "privsubnet_az" {
  type        = string
  description = "The availability zone for the private subnet"
}

# EKS cluster
variable "cluster_name" {
  type        = string
  description = "The name of the Cluster"
}

variable "cluster_version" {
  type        = string
  description = "The version of the Cluster"
}

# Security groups 
variable "sg_name" {
  type        = string
  description = "The name of the security group for the EKS cluster"
}
