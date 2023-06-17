region                  = "eu-central-1"

vpc_cidr_block          = "10.0.0.0/16"
pubsubnet_cidr_block    = "10.0.0.0/24"
privsubnet_cidr_block   = "10.0.1.0/24"
pubsubnet_az            = "eu-central-1a" 
privsubnet_az           = "eu-central-1b"

cluster_name            = "my-cluster"
cluster_version         = "1.27"

sg_name                 = "eks-cluster-sg"
