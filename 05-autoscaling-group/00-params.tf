# parms file for aws ec2 cloud

#### VPC Network
variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

#### HTTP PARAMS
variable "network_http" {
  default = {
    subnet_name = "subnet_http"
    cidr        = "192.168.1.0/24"
  }
}

# Set number of instance
variable "autoscaling_http" {
  default = {
    desired_capacity = "2"
    max_size         = "5"
    min_size         = "2"
  }
}

#### DB PARAMS
variable "network_db" {
  default = {
    subnet_name = "subnet_db"
    cidr        = "192.168.2.0/24"
  }
}

# Set number of instance
variable "autoscaling_db" {
  default = {
    desired_capacity = "2"
    max_size         = "5"
    min_size         = "1"
  }
}

